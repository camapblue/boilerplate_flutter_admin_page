import 'package:boilerplate_flutter_admin_page/services/services.dart';
import 'package:repository/repository.dart';

class Provider {
  static final Provider _singleton = Provider._internal();

  factory Provider() {
    return _singleton;
  }

  Provider._internal();

  FirebaseAuthService get firebaseAuthService => FirebaseAuthServiceImpl();
  UserService get userService => UserServiceImpl(
        firebaseAuthService: firebaseAuthService,
        userRepository: Repository().userRepository,
      );
}
