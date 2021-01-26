import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/base/simple_bloc_delegate.dart';
import 'package:boilerplate_flutter_admin_page/global/global.dart';
import 'package:boilerplate_flutter_admin_page/theme/theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: loadTheme(),
          home: Storybook(
            [
              ButtonStory(), // Supermama
              MenuBarStory(),
            ],
          ),
        );
      },
    ),
  );
}
