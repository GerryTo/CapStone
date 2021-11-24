import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/routes/route_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static late FluroRouter router;
  static String root = "/";
  static String login = "/login";
  static String registration = "/registration";

  static void init() {
    router = FluroRouter();
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          const NotFoundPage(),
    );
    router.define(root, handler: rootHandler);
    router.define(registration, handler: registrationHandler);
  }
}
