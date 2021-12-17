import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/favorite/screens/favorite_page.dart';
import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:capstone/modules/feeds/screens/feeds.dart';
import 'package:capstone/modules/feeds/viewmodel/feeds_viewmodel.dart';
import 'package:capstone/modules/home/viewmodel/home_viewmodel.dart';
import 'package:capstone/modules/search/screens/search_page.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const feeds = 0;
  static const search = 1;
  static const favorites = 2;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeViewModel, HomeIndex>(
      create: (_) => HomeViewModel(0),
      builder: (context, __) {
        return SafeArea(
          child: Scaffold(
            extendBody: true,
            body: _body(context),
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
              child: CurvedNavigationBar(
                height: 45,
                color: Theme.of(context).primaryColor,
                backgroundColor: Colors.transparent,
                index: context.watch<HomeIndex>().index,
                onTap: (index) => onBottomNavTap(context, index),
                items: const [
                  Icon(
                    Icons.feed,
                    size: 30,
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                  ),
                  Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                ],
              ),
            ),
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
        case search:
          return const SearchPage();
        case favorites:
          return ChangeNotifierProvider(
            create: (_) =>
                FavoriteViewModel(context.read<CurrentUserInfo>().userRef),
            child: const FavoritePage(),
          );
        default:
          return const NotFoundPage();
      }
    });
  }

  void onBottomNavTap(BuildContext context, index) {
    if (index == favorites && context.read<CurrentUserInfo>().id == null) {
      Routes.router.navigateTo(context, Routes.login);
    } else {
      context.read<HomeViewModel>().changeIndex(index);
    }
  }
}
