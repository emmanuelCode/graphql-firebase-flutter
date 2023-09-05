// TODO to create login form and email
import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';

class SignUpOrLogin extends ConsumerStatefulWidget {
  const SignUpOrLogin({super.key});

  @override
  SignUpOrLoginState createState() => SignUpOrLoginState();
}

class SignUpOrLoginState extends ConsumerState<SignUpOrLogin>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool _login;
  late Auth _auth;

  // TODO add TextEditingController for formfield
  final _textEditName = TextEditingController();
  final _textEditEmail = TextEditingController();
  final _textEditPass = TextEditingController();

  _handleTabChange() {
    if (_tabController.index == 0) {
      setState(() => _login = true);
    } else {
      setState(() => _login = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _login = true;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _auth = ref.read(authProvider.notifier);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase/GraphQL')),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_login) TextFormField(controller: _textEditName),
              TextFormField(controller: _textEditEmail),
              TextFormField(controller: _textEditPass),
              OutlinedButton(
                onPressed: () async {
                  _login
                      ? await _auth.logIn('dash@email.com', 'dashword')
                      : await _auth.signUp(
                          'Dash', 'dash@email.com', 'dashword');
                },
                child: Text(_login ? 'Login' : 'SignUp'),
              ),
              OutlinedButton(
                  onPressed: () async =>
                      await ref.read(userPostsProvider.notifier).createPost(),
                  child: const Text('Test')),
              OutlinedButton(
                  onPressed: () async => await _auth.logOut(),
                  child: const Text('LogOut'))
            ],
          ),
        ),
      ),
    );
  }
}
