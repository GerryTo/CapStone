import 'package:capstone/widget/card_feed.dart';
import 'package:flutter/material.dart';

class Feeds extends StatelessWidget {
  const Feeds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gazebo"),
        centerTitle: true,
        backgroundColor: const Color(0xff0B3D66),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CardFeed(),
        ],
      ),
    );
  }
}
