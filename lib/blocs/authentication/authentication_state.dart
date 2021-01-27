import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationState {}

class AuthSignInInProgress extends AuthenticationState {}

class AuthSignInSuccess extends AuthenticationState {}

class AuthSignInFailure extends AuthenticationState {}
