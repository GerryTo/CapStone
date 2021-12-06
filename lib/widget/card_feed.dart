import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/widget/user_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFeed extends StatelessWidget {
  const CardFeed(this.feed, {Key? key}) : super(key: key);
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    final userRef = feed.userReference;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Column(children: [
              Image.network(feed.images?.first ??
                  "https://via.placeholder.com/480x360?text=No+Picture")
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UserAvatar(userRef),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(feed.title ?? ""),
                            Text(feed.description ?? ""),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () =>
                        Routes.router.navigateTo(context, Routes.profileUser),
                    icon: Icon(Icons.arrow_right),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
