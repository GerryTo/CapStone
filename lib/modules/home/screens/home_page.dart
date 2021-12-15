import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/favorite/screens/favorite_page.dart';
import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:capstone/modules/feeds/screens/feeds.dart';
import 'package:capstone/modules/feeds/viewmodel/feeds_viewmodel.dart';
import 'package:capstone/modules/home/viewmodel/home_viewmodel.dart';
import 'package:capstone/modules/profile/screens/profile_page.dart';
import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
import 'package:capstone/modules/search/screens/search_page.dart';
import 'package:capstone/modules/settings/screens/settings_page.dart';
import 'package:capstone/modules/settings/viewmodel/settings_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const feeds = 0;
  static const favorites = 1;
  static const search = 2;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeViewModel, HomeIndex>(
      create: (_) => HomeViewModel(0),
      builder: (context, __) {
        return Scaffold(
          body: _body(context),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.watch<HomeIndex>().index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => onBottomNavTap(context, index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: 'feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'favorit',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'search',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<HomeIndex>(builder: (_, state, __) {
      switch (state.index) {
        case feeds:
          return ChangeNotifierProvider(
            create: (_) => FeedsViewModel(),
            child: const Feeds(),
          );
        case favorites:
          return ChangeNotifierProvider(
            create: (_) =>
                FavoriteViewModel(context.read<CurrentUserInfo>().userRef),
            child: const FavoritePage(),
          );

        case search:
          return SearchPage();
        default:
          return const NotFoundPage();
      }
    });
  }

  void onBottomNavTap(BuildContext context, index) {
    if (index != feeds && context.read<CurrentUserInfo>().id == null) {
      Routes.router.navigateTo(context, Routes.login);
    } else {
      context.read<HomeViewModel>().changeIndex(index);
    }
  }
}
