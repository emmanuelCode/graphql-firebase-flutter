// TODO to create login form and email
import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/views/list_post_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';

class SignUpOrLogin extends ConsumerStatefulWidget {
  const SignUpOrLogin({super.key});

  @override
  SignUpOrLoginState createState() => SignUpOrLoginState();
}

class SignUpOrLoginState extends ConsumerState<SignUpOrLogin> {
  late bool _login;
  late Auth _auth;

  final _textEditName = TextEditingController();
  final _textEditEmail = TextEditingController();
  final _textEditPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _login = true;
    _auth = ref.read(authProvider.notifier);
  }

  InputDecoration _decoration(String value) {
    return InputDecoration(
        border: const OutlineInputBorder(), labelText: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase/GraphQL'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_login) ...[
                  TextFormField(
                    controller: _textEditName,
                    decoration: _decoration('Name'),
                  ),
                  const SizedBox(height: 8),
                ],
                TextFormField(
                  controller: _textEditEmail,
                  decoration: _decoration('Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _textEditPass,
                  decoration: _decoration('Password'),
                  obscureText: true,
                ),
                OutlinedButton(
                  onPressed: () async {
                    _login
                        ? await _auth.logIn('dash@email.com', 'dashword')
                        : await _auth.signUp(
                            'Dash', 'dash@email.com', 'dashword');

                    if (_auth.token != null && context.mounted) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostsList()));
                    }
                    if(context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Sign Out')));
                    }
                  },
                  child: Text(_login ? 'Login' : 'SignUp'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          debugPrint('index $index');
          if (index == 0) {
            setState(() => _login = true);
          } else {
            setState(() => _login = false);
          }
        },
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.login_outlined), label: 'Login'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create_outlined), label: 'SignUp'),
        ],
      ),
    );
  }
}
