import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FirebaseAuthService {
  Future<UserCredential> login({
    @required String email,
    @required String password,
  });

  Future<void> signOut();
}
