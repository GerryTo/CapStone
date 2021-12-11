import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/card_feed_info.dart';
import 'package:capstone/modules/feeds/widgets/card_feed_photo.dart';

import 'package:capstone/routes/routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFeed extends StatelessWidget {
  const CardFeed(this.feed, {Key? key}) : super(key: key);
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    final userRef = feed.userReference;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CardFeedPhoto(feed.images?.first),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: GestureDetector(
                onTap: () => Routes.router.navigateTo(
                  context,
                  Routes.profileUser,
                  routeSettings: RouteSettings(
                    arguments: userRef,
                  ),
                ),
                child: CardFeedInfo(userRef: userRef, feed: feed),
              ),
            )
          ],
        ),
      ),
    );
  }
}
