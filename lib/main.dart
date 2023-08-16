import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_graphql/graphql_client.dart';
import 'package:graphql/client.dart';

import 'authentication.dart';
import 'firebase_options.dart';

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      // uses emulator 
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint('$e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late GraphQLClient client;
  late String addUserMutation;
  late MutationOptions options;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                addUserMutation = await rootBundle
                    .loadString('lib/graphql_queries/add_user.graphql');

                options = MutationOptions(
                  document: gql(addUserMutation),
                  variables: const <String, dynamic>{
                    // the variable put here must match the query variable ($user)
                    'user': {
                      'name': 'Jane Doe',
                      'description': 'related to John Doe',
                    }
                  },
                );

                final QueryResult result = await client.mutate(options);
                debugPrint('${result.data}');
                if (result.hasException) {
                    debugPrint('${result.exception}');

                }
              },
              child: const Text('Fetch DATA'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Auth auth = Auth(); // will be a provider
          await auth.logIn('dash@email.com', 'dashword');
          String? token = await auth.user.getIdToken();
          IdTokenResult? tokenResult = await auth.user.getIdTokenResult();

          // how to store it as a provider and use it in other places/models
          // I can't init a provider inside a class or method
          // @riverpod
          // GraphQLClient client(MyRef ref) {
          //   return graphQLClientInit('$token'); // pass firebase token
          // }
          client = graphQLClientInit('$token');
          debugPrint('$token');
          debugPrint(tokenResult.toString());

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
