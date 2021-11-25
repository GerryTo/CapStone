import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/config/themes/app_themes.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';

import 'modules/settings/provider/theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<ThemeNotifier, ThemeMode>(
      create: (_) => ThemeNotifier(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Gazebo',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          onGenerateRoute: Routes.router.generator,
          themeMode: context.watch<ThemeMode>(),
        );
      }),
    );
  }
}
