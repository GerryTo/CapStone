import 'package:capstone/modules/error/screens/not_found_page.dart';
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
  static String accountSettings = '/accountSettings';
  static String detailFeed = '/detailFeed';
  static const String addProject = '/addProject';

  static void init() {
    router = FluroRouter();
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          const NotFoundPage(),
    );
    router.define(root, handler: rootHandler);
    router.define(registration, handler: registrationHandler);
    router.define(home, handler: homeHandler);
    router.define(profileUser, handler: profileUserHandler);
    router.define(accountSettings, handler: accountSettingsHandler);
    router.define(detailFeed, handler: detailFeedHandeler);
    router.define(addProject, handler: addProjectHandler);
  }
}
