import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                    color: Color(0xff0B3D66),
                ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon( Icons.users
              ),
            )
          ],
        ),
      ),
    );
  }
}