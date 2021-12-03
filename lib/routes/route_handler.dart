import 'package:capstone/modules/auth/screens/login_page.dart';
import 'package:capstone/modules/feeds/screens/detail_feed.dart';

import 'package:capstone/modules/settings/screens/edit_profile_page.dart';
import 'package:capstone/modules/feeds/screens/detail_feed_profileku.dart';
import 'package:capstone/modules/profile/screens/profile_user_page.dart';
import 'package:capstone/modules/auth/screens/register_page.dart';
import 'package:capstone/modules/settings/screens/account_settings_page.dart';
import 'package:capstone/modules/feeds/screens/edit_feed.dart';
import 'package:capstone/modules/feeds/screens/add_feed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';

import '../modules/home/screens/home_page.dart';

final rootHandler =
    Handler(handlerFunc: (context, params) => const LoginPage());

final registrationHandler =
    Handler(handlerFunc: (context, params) => const RegisterPage());

final homeHandler = Handler(handlerFunc: (context, params) => const HomePage());

final profileUserHandler =
    Handler(handlerFunc: (context, params) => const ProfileUserPage());

final accountSettingsHandler =
    Handler(handlerFunc: (context, params) => AccountSettingsPage());

final detailFeedHandler =
    Handler(handlerFunc: (context, params) => const DetailFeedsPage());

final addProjectHandler =
    Handler(handlerFunc: (context, params) => const AddFeedPage());

final editProfileHandler =
    Handler(handlerFunc: (context, params) => EditProfilePage());

final detailFeedProfilKuHandeler =
    Handler(handlerFunc: (context, params)  {
        final args = context?.arguments as DocumentReference;
        return DetailFeedProfileKu(args);
    });

final editFeedHandeler =
    Handler(handlerFunc: (context, params) => EditFeedPage());
