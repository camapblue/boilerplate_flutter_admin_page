import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/global/global.dart';
import 'package:boilerplate_flutter_admin_page/modules/app/loading/loading.dart';
import 'package:boilerplate_flutter_admin_page/widgets/widgets.dart';

class AppShowing extends StatefulWidget {
  const AppShowing({Key key, @required this.app, @required this.navigatorKey})
      : super(key: key);

  final Widget app;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<StatefulWidget> createState() {
    return _AppShowingState();
  }
}

class _AppShowingState extends State<AppShowing> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          log.info('App Resumed from Background');
        }
        break;
      case AppLifecycleState.inactive:
        {
          log.info('App Change to Inactive');
        }
        break;
      case AppLifecycleState.paused:
        {
          log.info('App Paused');
        }
        break;
      case AppLifecycleState.detached:
        {
          log.info('Widget is detached');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShowMessageBloc, ShowMessageState>(
          listener: (_, state) {
            if (state is ShowWarningMessageSuccess) {
              Toast(
                state.messageKey,
                type: state.isSuccess ? ToastType.success : ToastType.failure,
              ).showWithNavigator(widget.navigatorKey.currentState);
            } else if (state is ShowErrorMessageSuccess) {
              Toast(
                  state.messageKey,
                  type: ToastType.failure,
                ).showWithNavigator(AppNavigator().navigatorKey.currentState);
            }
          },
        ),
      ],
      child: Stack(
        children: <Widget>[
          widget.app,
          const Loading(),
        ],
      ),
    );
  }
}
