import 'package:flutter/material.dart';
import 'package:repository/dao/base_dao.dart';
import 'package:repository/dao/user_dao.dart';
import 'package:repository/model/mapper.dart';
import 'package:repository/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _IsUserLoggedInKey = 'key_is_user_logged_in';

class UserDaoImpl extends BaseDao<User> implements UserDao {
  UserDaoImpl({@required SharedPreferences preferences})
      : super(mapper: Mapper<User>(parse: User.fromJson), prefs: preferences);

  @override
  Future<void> setUserLoggedIn() async {
    await saveBoolean(true, _IsUserLoggedInKey);
  }

  @override
  Future<void> setUserLoggedOut() async {
    await saveBoolean(false, _IsUserLoggedInKey);
  }

  @override
  bool isUserLoggedIn() {
    return getBoolean(_IsUserLoggedInKey) ?? false;
  }
}
