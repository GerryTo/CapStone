import 'package:capstone/widget/card_feed.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
          title: const Text("Gazebo"),
          centerTitle: true,
          backgroundColor: const Color(0xff0B3D66)),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Color(0xff0B3D66),
      //         ),
      //         child: Row(
      //           children: [
      //             const Icon(Icons.person, size: 100, color: Colors.white),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const [
      //                 Text("Nama ",
      //                     style: TextStyle(color: Colors.white, fontSize: 16)),
      //                 Text("Email@email.com",
      //                     style: TextStyle(color: Colors.white, fontSize: 16))
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person, size: 30),
      //         title: const Text('Profil', style: TextStyle(fontSize: 16)),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.favorite, size: 30),
      //         title: const Text('Favori', style: TextStyle(fontSize: 16)),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.settings, size: 30),
      //         title: const Text('Setingan', style: TextStyle(fontSize: 16)),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: IndexedStack(
        index: pageIndex,
        children: const [
          Feeds(),
          Center(child: Text('Profil')),
          Center(child: Text('Favorit')),
          Center(child: Text('Setelan')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

class Feeds extends StatelessWidget {
  const Feeds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CardFeed(),
      ],
    );
  }
}
