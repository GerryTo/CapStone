
import 'package:capstone/widget/card_feed.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Gazebo"),
          centerTitle: true,
          backgroundColor: Color(0xff0B3D66)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff0B3D66),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, size: 100, color: Colors.white),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nama ",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text("Email@email.com",
                          style: TextStyle(color: Colors.white, fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, size: 30),
              title: const Text('Profil', style: TextStyle(fontSize: 16)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.favorite, size: 30),
              title: const Text('Favori', style: TextStyle(fontSize: 16)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 30),
              title: const Text('Setingan', style: TextStyle(fontSize: 16)),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CardFeed(),
          ],
        ),
      )
    );
  }
}
