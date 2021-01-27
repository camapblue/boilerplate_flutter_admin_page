import 'package:repository/repository.dart';

abstract class SessionEvent {
  const SessionEvent();
}

// event for load stored session for auto login
class SessionLoaded extends SessionEvent {}

class SessionUserLoggedIn extends SessionEvent {
  final User user;

  SessionUserLoggedIn(this.user);
}

class SessionUserSignedOut extends SessionEvent {}
