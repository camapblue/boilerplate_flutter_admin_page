import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/modules/base/layout_template.dart';
import 'package:boilerplate_flutter_admin_page/modules/home/home_view.dart';
import 'package:boilerplate_flutter_admin_page/modules/league/league_view.dart';
import 'package:boilerplate_flutter_admin_page/modules/log_in/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/splash_screen/splash_screen_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.splashScreen:
        return _getPageRoute(const SplashScreenPage(), settings);
      case Pages.logIn:
        return _getPageRoute(
            BlocProvider(
              create: (_) => AuthenticationBloc.instance(),
              child: const LogInPage(),
            ),
            settings);
      case Pages.dashboard:
        return _getPageRoute(const LayoutTemplate(), settings);
      default:
        return _getPageRoute(Text('Page ${settings.name} not found'), settings);
    }
  }

  static Route<dynamic> generateDashboardRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _getPageRoute(const HomeView(), settings);
      case Pages.league:
        return _getPageRoute(const LeagueView(), settings);
      default:
        return _getPageRoute(Text('Page ${settings.name} not found'), settings);
    }
  }

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return _FadeRouteTransition(
        pageBuilder: (context) => child,
        settings: settings,
        duration: const Duration(milliseconds: 250),
      );
  }
}

class _FadeRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration duration;

  _FadeRouteTransition({
    @required this.pageBuilder,
    @required RouteSettings settings,
    this.duration,
  })  : assert(pageBuilder != null, 'Must provide page builder!'),
        super(settings: settings);

  @override
  Color get barrierColor => Colors.black.withAlpha(1);

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>
      duration ?? const Duration(milliseconds: 300);

  @override
  bool get opaque => false;
}
