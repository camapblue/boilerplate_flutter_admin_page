import 'package:repository/model/model.dart';

abstract class UserCloudFunctions {
  Future<User> get me;
}
