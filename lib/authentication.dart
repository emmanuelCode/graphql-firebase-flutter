import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth {

 User? user; 

 Future<void> logIn(String email, String password) async {
   final credential = await FirebaseAuth.instance
       .signInWithEmailAndPassword(email: email, password: password);
   if (credential.user != null) {
     user = credential.user!;
     debugPrint('logged in as ${user!.displayName}');
   } else {
     debugPrint('no user!');
   }
 } 
 
 

}

