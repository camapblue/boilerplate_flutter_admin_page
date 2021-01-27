import 'package:boilerplate_flutter_admin_page/global/global.dart';
import 'package:flutter/foundation.dart';

import 'blocs.dart';

final Map<Type, Object Function(Key key)> blocConstructors = {
  ConnectivityBloc: (Key key) => ConnectivityBloc(key),
  AuthenticationBloc: (Key key) =>
      AuthenticationBloc(key, userService: Provider().userService),
  ShowMessageBloc: (Key key) => ShowMessageBloc(key),
  LoaderBloc: (Key key) => LoaderBloc(key),
  SessionBloc: (Key key) => SessionBloc(
        key,
        userService: Provider().userService,
      ),
};
