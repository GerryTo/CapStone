import 'package:cached_network_image/cached_network_image.dart';
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
              CachedNetworkImage(
                imageUrl: feed.images?.first ??
                    "https://via.placeholder.com/480x360?text=No+Picture",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
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
