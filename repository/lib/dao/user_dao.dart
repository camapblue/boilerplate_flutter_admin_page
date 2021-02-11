abstract class UserDao {
  Future<void> setUserLoggedIn();

  Future<void> setUserLoggedOut();

  bool isUserLoggedIn();
}
