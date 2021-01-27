import 'dart:async';

import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/blocs/mixin/app_loader.dart';
import 'package:boilerplate_flutter_admin_page/blocs/mixin/message_showing.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/services/user_service.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends BaseBloc<AuthenticationEvent, AuthenticationState>
    with MessageShowing, AppLoader {
  final UserService userService;
  AuthenticationBloc(Key key, {@required this.userService}) : super(key);

  factory AuthenticationBloc.instance() {
    return EventBus()
        .newBloc<AuthenticationBloc>(Keys.Blocs.authenticationBloc);
  }

  @override
  AuthenticationState get initialState => AuthInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationSignedIn) {
      yield* _mapAuthSignedIn(event);
    }
  }

  Stream<AuthenticationState> _mapAuthSignedIn(
      AuthenticationSignedIn event) async* {
    yield AuthSignInInProgress();

    try {
      final user = await userService.login(
        email: event.email,
        password: event.password,
      );

      EventBus().broadcast(
        BroadcastEvent.justLoggedIn,
        params: {'user': user},
      );

      yield AuthSignInSuccess();
    } catch (e) {
      showFailureMessage(e.toString());

      yield AuthSignInFailure();
    }
  }
}
