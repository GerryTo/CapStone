import 'package:capstone/modules/auth/screens/login_page.dart';
import 'package:capstone/modules/auth/screens/register_page.dart';
import 'package:fluro/fluro.dart';

final rootHandler =
    Handler(handlerFunc: (context, params) => const LoginPage());

final registrationHandler =
    Handler(handlerFunc: (context, params) => const RegisterPage());
