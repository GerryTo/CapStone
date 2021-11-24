import 'package:capstone/routes/route_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static late FluroRouter router;
  static String root = "/";
  static String login = "/login";
  static String registration = "/registration";
  static String home = "/home";
  static String profileUser = "/profileUser";

  static void init() {
    router = FluroRouter();
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(root, handler: rootHandler);
    router.define(registration, handler: registrationHandler);
    router.define(home, handler: homeHandler);
    router.define(profileUser, handler: profileUserHandler);
  }
}
