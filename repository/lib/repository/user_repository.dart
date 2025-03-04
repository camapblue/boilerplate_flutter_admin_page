import 'package:repository/model/model.dart';
import 'package:repository/repository.dart';

abstract class UserRepository {
  Future<User> get me;

  bool get isUserLoggedIn;

  Future<void> setUserLoggedIn();

  Future<void> setUserLoggedOut();
}
