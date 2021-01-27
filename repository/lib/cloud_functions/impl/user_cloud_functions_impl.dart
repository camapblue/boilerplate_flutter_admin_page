import 'package:repository/cloud_functions/base_cloud_functions.dart';
import 'package:repository/cloud_functions/cloud_functions.dart';
import 'package:repository/model/user.dart';

class UserCloudFunctionsImpl extends BaseCloudFunctions
    implements UserCloudFunctions {
  UserCloudFunctionsImpl() : super();

  @override
  Future<User> get me async {
      final json = await call('admin-api-user-me');

      return User.fromJson(json['user']);
  }
}
