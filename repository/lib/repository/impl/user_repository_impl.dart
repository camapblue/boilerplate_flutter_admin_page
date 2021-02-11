import 'package:flutter/foundation.dart';
import 'package:repository/cloud_functions/cloud_functions.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository/repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserCloudFunctions userCloudFunctions;
  final UserDao userDao;

  const UserRepositoryImpl({
    @required this.userCloudFunctions,
    @required this.userDao,
  });

  @override
  Future<User> get me {
    return userCloudFunctions.me;
  }

  @override
  bool get isUserLoggedIn {
    return userDao.isUserLoggedIn();
  }

  @override
  Future<void> setUserLoggedIn() async {
    await userDao.setUserLoggedIn();
  }

  @override
  Future<void> setUserLoggedOut() async {
    await userDao.setUserLoggedOut();
  }
}
