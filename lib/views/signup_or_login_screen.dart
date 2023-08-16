// TODO to create login form and email
import 'package:flutter/material.dart';

import '../authentication.dart';

class SignUpOrLogin extends StatefulWidget {
  const SignUpOrLogin({super.key});

  @override
  State<SignUpOrLogin> createState() => _SignUpOrLoginState();
}

class _SignUpOrLoginState extends State<SignUpOrLogin>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool _login;
  late Auth _auth;

  // TODO add TextEditingController for formfield

  _handleTabChange() {
    if (_tabController.index == 0) {
      setState(() => _login = true);
    } else {
      setState(() => _login = false);
    }
  }

  @override
  void initState() {
    _login = true;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _auth = Auth();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_login) TextFormField(),
        TextFormField(),
        TextFormField(),
        OutlinedButton(
          onPressed: () async {
            _login ? await _auth.logIn('','') : await _auth.signUp('Dash','dash@email.com','dashword');
            
          },
          child: Text(_login ? 'Login' : 'SignUp'),
        )
      ],
    );
  }
}
