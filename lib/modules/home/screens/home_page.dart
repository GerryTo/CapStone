import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/favorite/screens/favorite_page.dart';
import 'package:capstone/modules/feeds/screens/feeds.dart';
import 'package:capstone/modules/home/viewmodel/home_viewmodel.dart';
import 'package:capstone/modules/profile/screens/profile_page.dart';
import 'package:capstone/modules/settings/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeViewModel, HomeIndex>(
      create: (context) => HomeViewModel(0),
      builder: (ctx, __) {
        return Scaffold(
          body: _body(ctx),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ctx.watch<HomeIndex>().index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => ctx.read<HomeViewModel>().changeIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'feed'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'profilku'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorit'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'setelan'),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    final pages = [
      const Feeds(),
      ProfilePage(context.read<CurrentUserInfo>().userRef!),
      const FavoritePage(),
      const SettingsPage(),
    ];
    return Consumer<HomeIndex>(builder: (_, state, __) {
      return pages[state.index];
    });
  }
}
