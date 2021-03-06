import 'package:capstone/config/themes/app_themes.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'modules/settings/provider/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceLocator.registerServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUserInfo(),
        ),
        //ini untuk darkmode
        StateNotifierProvider<ThemeNotifier, ThemeMode>(
            create: (_) => ThemeNotifier()),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gazebo',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        onGenerateRoute: Routes.router.generator,
        themeMode: context.watch<ThemeMode>(),
      ),
    );
  }
}
