import 'package:capstone/modules/auth/screens/login_page.dart';
import 'package:capstone/modules/feeds/screens/detail_feed.dart';

import 'package:capstone/modules/settings/screens/edit_profile_page.dart';
import 'package:capstone/modules/feeds/screens/detail_feed_profileku.dart';
import 'package:capstone/modules/profile/screens/profile_user_page.dart';
import 'package:capstone/modules/auth/screens/register_page.dart';
import 'package:capstone/modules/settings/screens/account_settings_page.dart';
import 'package:capstone/modules/feeds/screens/edit_feed.dart';
import 'package:capstone/modules/upload_project/screens/add_project_page.dart';
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
    Handler(handlerFunc: (context, params) => const AccountSettingsPage());

final detailFeedHandler =
    Handler(handlerFunc: (context, params) => const DetailFeedsPage());

final addProjectHandler =
    Handler(handlerFunc: (context, params) => const AddProjectPage());

final editProfileHandler =
    Handler(handlerFunc: (context, params) => const EditProfilePage());

final detailFeedProfilKuHandeler =
    Handler(handlerFunc: (context, params) => DetailFeedProfileKu());

final editFeedHandeler =
    Handler(handlerFunc: (context, params) => EditFeedPage());
