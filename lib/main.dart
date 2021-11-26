import 'package:capstone/config/themes/app_themes.dart';
import 'package:capstone/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'modules/settings/provider/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
