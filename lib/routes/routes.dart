import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/routes/route_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static FluroRouter? _router;
  static FluroRouter get router {
    if (_router != null) {
      return _router!;
    } else {
      _router = _init();
      return _router!;
    }
  }

  // static const String root = "/";
  static const String login = "/login";
  static const String registrationArchitect = "/registrationArchitect";
  static const String registrationClient = "/registrationClient";
  static const String preregister = '/preregister';
  static const String home = "/";
  static const String profileUser = "/profileUser";
  static const String accountSettings = '/accountSettings';
  static const String detailFeed = '/detailFeed';
  static const String addProject = '/addProject';

  static const String editProfile = '/editProfile';
  // static const String detailFeedProfilKu = '/detailFeedProfilKu';
  static const String editFeed = '/editFeed';
  static const String search = '/search';

  static const String settings = '/settings';

  static FluroRouter _init() {
    final router = FluroRouter();
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          const NotFoundPage(),
    );
    router.define(login, handler: loginHandler);
    router.define(preregister, handler: preregisterHandler);
    router.define(registrationArchitect, handler: registrationArchitectHandler);
    router.define(registrationClient, handler: registrationClientHandler);

    router.define(home, handler: homeHandler);
    router.define(profileUser, handler: profileUserHandler);
    router.define(accountSettings, handler: accountSettingsHandler);
    router.define(detailFeed, handler: detailFeedHandler);
    router.define(addProject, handler: addProjectHandler);
    router.define(editProfile, handler: editProfileHandler);
    // router.define(detailFeedProfilKu, handler: detailFeedProfilKuHandeler);
    router.define(editFeed, handler: editFeedHandeler);
    router.define(search, handler: searchHandler);

    router.define(settings, handler: settingsHandler);

    return router;
  }
}
