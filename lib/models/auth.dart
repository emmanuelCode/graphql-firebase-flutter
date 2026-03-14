import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../graphql_client.dart';

part 'auth.g.dart';

// this riverpod class gives me the state of Firebase User variable
// where I can get info on the user such as token, name, email etc.
@riverpod 
class Auth extends _$Auth {
  @override
  ({User? user, String? token}) build() =>
      (user: FirebaseAuth.instance.currentUser, token: null);

  Future<void> logIn(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      final token = await credential.user!.getIdToken();
      state = (user: credential.user, token: token);

      debugPrint('STATE: $state');
      debugPrint('logged in as ${state.user!.displayName}');
      debugPrint('USER_ID: ${state.user!.uid}');
    } else {
      debugPrint('no user!');
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      final token = await credential.user!.getIdToken();

      // Update display name on the newly created user
      await credential.user!.updateDisplayName(name);
      
      // Get fresh user reference from FirebaseAuth after update
      final currentUser = FirebaseAuth.instance.currentUser;
      state = (user: currentUser, token: token);

      debugPrint('logged in as ${state.user!.displayName}');
      debugPrint('USER_ID: ${state.user!.uid}');
    } else {
      debugPrint('no user!');
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

@riverpod
GraphQLClient graphQLClient(Ref ref, String token) => graphQLClientInit(token);
