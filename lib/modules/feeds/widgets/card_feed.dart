import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/card_feed_info.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:capstone/routes/routes.dart';
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
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: _photo(),
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

  Widget _photo() {
    final photoUrl = feed.images?.first;
    if (photoUrl == null) {
      return const PhotoPlaceHolder();
    }
    return CachedNetworkImage(
      imageUrl: photoUrl,
      placeholder: (context, url) => const PhotoPlaceHolder(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
