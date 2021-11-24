import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  Routes.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gazebo',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
      ),
      onGenerateRoute: Routes.router.generator,
    );
  }
}
