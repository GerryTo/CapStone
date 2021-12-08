import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
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
              child: CachedNetworkImage(
                imageUrl: feed.images?.first ??
                    "https://via.placeholder.com/480x360?text=No+Picture",
                placeholder: (context, url) => const PhotoPlaceHolder(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
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
                child: _cardInfo(context, userRef),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardInfo(BuildContext context, DocumentReference<Object?>? userRef) {
    return FutureBuilder<DocumentSnapshot>(
      future: userRef?.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feed.title ?? "",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CachedNetworkImage(
                    height: 32,
                    width: 32,
                    imageUrl: data["avatar_url"],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data["name"] ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 16),
                  const Spacer(),
                  Text(
                    data["company"] ?? "",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox(
          height: 32,
        );
      },
    );
  }
}
