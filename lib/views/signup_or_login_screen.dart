import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/views/post_list_screen.dart';
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

  int _bottomNavigationBarIndex = 0;

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

  _setLogin(bool login) {
    _login = login;
    //reset text field when changing state
    _textEditName.text = '';
    _textEditEmail.text = '';
    _textEditPass.text = '';
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
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () async {
                    _login
                        ? await _auth.logIn(
                            _textEditEmail.text, _textEditPass.text)
                        : await _auth.signUp(_textEditName.text,
                            _textEditEmail.text, _textEditPass.text);

                    if (_auth.username != null && context.mounted) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostsListScreen()));
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign Out')));
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
          _bottomNavigationBarIndex = index;
          if (index == 0) {
            setState(() => _setLogin(true));
          } else {
            setState(() => _setLogin(false));
          }
        },
        showSelectedLabels: true,
        currentIndex: _bottomNavigationBarIndex,
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
