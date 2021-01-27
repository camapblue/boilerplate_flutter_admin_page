import 'package:flutter/foundation.dart';
import 'package:repository/cloud_functions/cloud_functions.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository/repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserCloudFunctions userCloudFunctions;
  const UserRepositoryImpl({
    @required this.userCloudFunctions,
  });

  @override
  Future<User> get me {
    return userCloudFunctions.me;
  }
}
