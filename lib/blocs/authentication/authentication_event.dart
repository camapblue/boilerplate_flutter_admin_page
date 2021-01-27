import 'package:flutter/material.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationSignedIn extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationSignedIn({@required this.email, @required this.password});
}
