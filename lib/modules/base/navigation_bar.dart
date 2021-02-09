import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/app_icons.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/theme/theme.dart';
import 'package:boilerplate_flutter_admin_page/widgets/widgets.dart';

class _NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.pink,
      child: Row(
        children: <Widget>[
          InkWellButton(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: const Icon(Icons.menu),
          ),
          const SizedBox(width: 24),
          SizedBox(
            height: 48,
            width: 64,
            child: AppImage(image: AppImagesAsset.logo),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                height: 64,
                width: 100,
                child: AppImage(image: AppImagesAsset.logo),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    image: AppImagesAsset.logo,
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    EventBus().user.email,
                    style: theme.primaryRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              BlocListener<SessionBloc, SessionState>(
                condition: (_, state) => state is SessionSignOutSuccess,
                listener: (_, state) {
                  if (state is SessionSignOutSuccess) {
                    Navigator.of(context)
                        .pushReplacementNamed(Pages.splashScreen);
                  }
                },
                child: InkWellButton(
                  onTap: () => EventBus().event<SessionBloc>(
                    Keys.Blocs.sessionBloc,
                    SessionUserSignedOut(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(
                        icon: AppIcons.logout,
                        width: 50,
                        height: 50,
                        color: AppColors.pink,
                      ),
                      Text(
                        'Logout',
                        style: theme.primaryRegular.copyWith(
                          fontSize: 12,
                          color: AppColors.dark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar();

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _NavigationBarMobile(),
      tablet: _NavigationBarTabletDesktop(),
    );
  }
}
