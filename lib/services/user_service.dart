import 'package:flutter/material.dart';
import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> login({@required String email, @required String password});
  Future<User> get user;
  Future<void> signOut();
}
