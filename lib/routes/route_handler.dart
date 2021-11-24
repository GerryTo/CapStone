import 'package:capstone/modules/auth/screens/login_page.dart';
import 'package:capstone/modules/profile/screens/profile_user_page.dart';
import 'package:capstone/modules/auth/screens/register_page.dart';
import 'package:fluro/fluro.dart';

import '../modules/home/screens/home_page.dart';

final rootHandler =
    Handler(handlerFunc: (context, params) => const LoginPage());

final registrationHandler =
    Handler(handlerFunc: (context, params) => const RegisterPage());

final homeHandler = Handler(handlerFunc: (context, params) => HomePage());

final profileUserHandler =
    Handler(handlerFunc: (context, params) => const ProfileUserPage());
