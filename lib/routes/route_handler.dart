import 'package:capastone/modules/auth/screens/login_page.dart';
import 'package:capastone/modules/auth/screens/profile_iser_page.dart';
import 'package:capastone/modules/auth/screens/register_page.dart';
import 'package:fluro/fluro.dart';

import '../modules/auth/screens/home_page.dart';

final rootHandler =
    Handler(handlerFunc: (context, params) => const LoginPage());

final registrationHandler =
    Handler(handlerFunc: (context, params) => const RegisterPage());

final homeHandler =
    Handler(handlerFunc: (context, params) => HomePage());

final profileUserHandler =
    Handler(handlerFunc: (context, params) => profileUserPage());
