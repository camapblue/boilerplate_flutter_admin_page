import 'package:flutter/foundation.dart';

// import 'package:boilerplate_flutter_admin_page/global/global.dart' show Provider;

import 'blocs.dart';

final Map<Type, Object Function(Key key)> blocConstructors = {
  ConnectivityBloc: (Key key) => ConnectivityBloc(key),
};
