import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/theme/theme.dart';
import 'package:boilerplate_flutter_admin_page/widgets/widgets.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage();

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   EventBus().event<SessionBloc>(Keys.Blocs.sessionBloc, SessionLoaded());
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<SessionBloc, SessionState>(
        condition: (_, state) =>
            state is SessionUserLogInSuccess || state is SessionGuestMode,
        listener: (_, state) async {
          if (state is SessionUserLogInSuccess) {
            await Navigator.of(context).pushReplacementNamed(Pages.dashboard);
          } else if (state is SessionGuestMode) {
            await Navigator.of(context).pushReplacementNamed(Pages.logIn);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(
                image: AppImagesAsset.logo,
                width: 230,
                height: 136,
              ),
              const SizedBox(height: 24),
              Text(
                'Loading...',
                style: theme.primaryRegular.copyWith(
                  fontSize: 30,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
