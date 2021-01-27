import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/global/global.dart';
import 'package:boilerplate_flutter_admin_page/modules/base/navigation_menu/navigation_menu.dart';
import 'package:boilerplate_flutter_admin_page/routes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:boilerplate_flutter_admin_page/modules/base/navigation_drawer/navigation_drawer.dart';
import 'package:boilerplate_flutter_admin_page/modules/base/centered_view.dart';
import 'package:boilerplate_flutter_admin_page/modules/base/navigation_bar.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.isMobile ? const NavigationDrawer() : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              const NavigationBar(),
              Expanded(
                child: Row(
                  children: [
                    if (!sizingInformation.isMobile) const NavigationMenu(),
                    Expanded(
                      child: Container(
                        padding: sizingInformation.isMobile
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(16),
                        color: AppColors.light,
                        child: Navigator(
                          key: AppNavigator().navigatorKey,
                          onGenerateRoute: Routes.generateDashboardRoute,
                          initialRoute: Pages.home,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
