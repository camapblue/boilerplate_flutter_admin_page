library repository;

import 'package:repository/cloud_functions/cloud_functions.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'exception/exception.dart';
export 'model/model.dart';
export 'package:repository/repository/repository.dart';

class Repository {
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  SharedPreferences _sharedPreferences;

  // Dao
  UserDao get userDao => UserDaoImpl(preferences: _sharedPreferences);

  // Cloud Functions
  UserCloudFunctions get userCloudFunctions => UserCloudFunctionsImpl();

  // Repository
  UserRepository get userRepository => UserRepositoryImpl(
        userCloudFunctions: userCloudFunctions,
        userDao: userDao,
      );
}
