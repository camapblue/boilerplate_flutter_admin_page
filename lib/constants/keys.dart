import 'package:flutter/foundation.dart';

class Keys {
  static _Blocs get Blocs => _Blocs();
}

class _Blocs {
  static final _Blocs _singleton = _Blocs._internal();

  factory _Blocs() {
    return _singleton;
  }

  _Blocs._internal();

  // One instance at the given time
  final Key noneDisposeBloc = const Key('none_dispose_bloc');
  final Key forceToDisposeBloc = const Key('force_to_dispose_bloc');

  final Key connectivityBloc = const Key('connectivity_bloc');
  final Key showMessageBloc = const Key('show_message_bloc');
  final Key sessionBloc = const Key('session_bloc');
  final Key loaderBloc = const Key('loader_bloc');
  final Key authenticationBloc = const Key('authentication_bloc');
}
