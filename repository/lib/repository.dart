library repository;

import 'package:repository/cloud_functions/cloud_functions.dart';
import 'package:repository/repository/repository.dart';

export 'exception/exception.dart';
export 'model/model.dart';
export 'package:repository/repository/repository.dart';

class Repository {
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  // Cloud Functions
  UserCloudFunctions get userCloudFunctions => UserCloudFunctionsImpl();

  UserRepository get userRepository => UserRepositoryImpl(
        userCloudFunctions: userCloudFunctions,
      );
}
