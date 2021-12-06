import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/feeds/screens/feeds.dart';
import 'package:capstone/modules/profile/screens/profile_page.dart';
import 'package:capstone/modules/settings/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [
          const Feeds(),
          ProfilePage(context.read<CurrentUserInfo>().userRef!),
          const Center(child: Text('Favorit')),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          pageIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profilku'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setelan'),
        ],
      ),
    );
  }
}
