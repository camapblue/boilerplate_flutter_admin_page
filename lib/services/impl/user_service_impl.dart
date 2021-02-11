import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:boilerplate_flutter_admin_page/services/services.dart';

class UserServiceImpl implements UserService {
  final FirebaseAuthService firebaseAuthService;
  final UserRepository userRepository;

  const UserServiceImpl({
    @required this.firebaseAuthService,
    @required this.userRepository,
  });

  @override
  Future<User> login({
    @required String email,
    @required String password,
  }) async {
    final credential = await firebaseAuthService.login(
      email: email,
      password: password,
    );
    log.info('ADMIN ACCESS TOKEN = ${await credential.user.getIdToken()}');

    return userRepository.me;
  }

  @override
  Future<User> get user async {
    return userRepository.isUserLoggedIn ? userRepository.me : null;
  }

  @override
  Future<void> signOut() {
    return firebaseAuthService.signOut();
  }
}
