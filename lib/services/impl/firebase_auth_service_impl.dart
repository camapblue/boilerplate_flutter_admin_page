import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:boilerplate_flutter_admin_page/services/services.dart';

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  @override
  Future<UserCredential> login({String email, String password}) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();

  @override
  Future<bool> isLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
