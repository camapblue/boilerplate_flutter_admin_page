import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/services/services.dart';

import 'session.dart';

class SessionBloc extends BaseBloc<SessionEvent, SessionState>
    with AppLoader, MessageShowing {
  final UserService userService;

  SessionBloc(
    Key key, {
    @required this.userService,
  }) : super(key);

  factory SessionBloc.instance() {
    return EventBus().newBloc<SessionBloc>(Keys.Blocs.sessionBloc);
  }

  @override
  List<Broadcast> subscribes() {
    return [
      Broadcast(
        blocKey: key,
        event: BroadcastEvent.justLoggedIn,
        onNext: (data) {
          final User user = data['user'];

          add(SessionUserLoggedIn(user));
        },
      )
    ];
  }

  @override
  SessionState get initialState => SessionInitial();

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is SessionLoaded) {
      yield* _mapEventSessionLoadedToState(event);
    } else if (event is SessionUserSignedOut) {
      yield* _mapEventUserSignedOutToState(event);
    } else if (event is SessionUserLoggedIn) {
      yield SessionUserLogInSuccess(user: event.user);
    }
  }

  Stream<SessionState> _mapEventSessionLoadedToState(
      SessionLoaded event) async* {
    try {
      final user = await userService.user;

      if (user != null) {
        yield SessionUserLogInSuccess(user: user);
      } else {
        yield SessionGuestMode();
      }
    } catch (e) {
      yield SessionGuestMode();
    }
  }

  Stream<SessionState> _mapEventUserSignedOutToState(
      SessionUserSignedOut event) async* {
    showAppLoading();

    try {
      await userService.signOut();

      yield SessionSignOutSuccess();
    } catch (e) {
      showFailureMessage(e.toString());
    } finally {
      hideAppLoading();
    }
  }
}
