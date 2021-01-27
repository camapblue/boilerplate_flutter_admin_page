import 'package:boilerplate_flutter_admin_page/modules/app/app_showing/app_showing.dart';
import 'package:boilerplate_flutter_admin_page/routes.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boilerplate_flutter_admin_page/theme/theme.dart';
import 'blocs/blocs.dart';
import 'constants/constants.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) =>
              ConnectivityBloc.instance()..add(ConnectivityChecked()),
        ),
        BlocProvider<ShowMessageBloc>(
          create: (_) => ShowMessageBloc.instance(),
        ),
        BlocProvider<LoaderBloc>(create: (_) => LoaderBloc.instance()),
        BlocProvider<SessionBloc>(
          create: (_) => SessionBloc.instance()..add(SessionLoaded()),
        ),
      ],
      child: MaterialApp(
        title: 'Dashboard',
        debugShowCheckedModeBanner: false,
        theme: loadTheme(),
        navigatorKey: rootNavigator,
        home: AppShowing(
          app: const Navigator(
            onGenerateRoute: Routes.generateRoute,
            initialRoute: Pages.splashScreen,
          ),
          navigatorKey: rootNavigator,
        ),
      ),
    );
  }
}
