import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'modules/auth/screens/login_page.dart';
import 'routes/routes.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.router.generator,
    );
  }
}
