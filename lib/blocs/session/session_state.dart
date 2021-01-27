import 'package:equatable/equatable.dart';
import 'package:repository/model/user.dart';

abstract class SessionState extends Equatable {
  final User user;

  SessionState({this.user});

  @override
  List<Object> get props => [user];
}

class SessionInitial extends SessionState {}

class SessionGuestMode extends SessionState {}

class SessionUserLogInSuccess extends SessionState {
  SessionUserLogInSuccess({User user}) : super(user: user);
}

class SessionSignOutSuccess extends SessionState {}
