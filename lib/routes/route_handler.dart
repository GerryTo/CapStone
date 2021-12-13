import 'package:capstone/modules/auth/screens/login_page.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/feeds/screens/detail_feed.dart';
import 'package:capstone/modules/profile/screens/profile_page.dart';
import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';

import 'package:capstone/modules/settings/screens/edit_profile_page.dart';
import 'package:capstone/modules/auth/screens/register_page.dart';
import 'package:capstone/modules/settings/screens/account_settings_page.dart';
import 'package:capstone/modules/feeds/screens/edit_feed.dart';
import 'package:capstone/modules/feeds/screens/add_feed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../modules/home/screens/home_page.dart';

final rootHandler =
    Handler(handlerFunc: (context, params) => const LoginPage());

final registrationHandler =
    Handler(handlerFunc: (context, params) => const RegisterPage());

final homeHandler = Handler(handlerFunc: (context, params) => const HomePage());

final profileUserHandler = Handler(handlerFunc: (context, params) {
  final args = context?.settings?.arguments as DocumentReference?;
  return ChangeNotifierProvider(
    create: (_) => ProfileViewModel(args),
    child: const ProfilePage(),
  );
});

final accountSettingsHandler =
    Handler(handlerFunc: (context, params) => AccountSettingsPage());

final detailFeedHandler = Handler(handlerFunc: (context, params) {
  final args = context?.settings?.arguments as DocumentReference?;
  if (args == null) {
    return const NotFoundPage();
  }
  return DetailFeedsPage(args);
});

final addProjectHandler =
    Handler(handlerFunc: (context, params) => const AddFeedPage());

final editProfileHandler =
    Handler(handlerFunc: (context, params) => EditProfilePage());

// final detailFeedProfilKuHandeler = Handler(handlerFunc: (context, params) {
//   final args = context?.arguments as DocumentReference;
//   return DetailFeedProfileKu(args);
// });

final editFeedHandeler = Handler(handlerFunc: (context, params) {
  final args = context?.arguments as DocumentReference;
  return EditFeedPage(args);
});
