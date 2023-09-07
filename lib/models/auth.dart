import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../graphql_client.dart';

part 'auth.g.dart';

// this riverpod class gives me the state of Firebase User variable
// where I can get info on the user such as token, name, email etc.
@Riverpod(keepAlive: true) // so that the token variable doesn't get disposed
class Auth extends _$Auth {
  String? token;
  String? username;

  @override
  User? build() => FirebaseAuth.instance.currentUser;

  Future<void> logIn(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    debugPrint('STATE: $state');
    if (credential.user != null) {
      state = credential.user!;
      token = await state!.getIdToken();
      username = state!.displayName;
      debugPrint('TOKEN $token}');
      debugPrint('logged in as ${state!.displayName}');
    } else {
      debugPrint('no user!');
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    username = name;
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      state = credential.user!;
      token = await state!.getIdToken();
      // will not be available on account creation (state!.displayName)
      await state!.updateDisplayName(name);
      debugPrint('logged in as $username');
      debugPrint('TOKEN: $token}');
    } else {
      debugPrint('no user!');
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

@riverpod
GraphQLClient graphQLClient(GraphQLClientRef ref, String token) =>
    graphQLClientInit(token);
