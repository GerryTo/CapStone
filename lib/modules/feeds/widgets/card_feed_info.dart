import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardFeedInfo extends StatelessWidget {
  const CardFeedInfo({
    required this.userRef,
    required this.feed,
    Key? key,
  }) : super(key: key);
  final DocumentReference<Object?>? userRef;
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: userRef?.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          final user = User.fromMap(data);
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
                    imageUrl: user.avatarUrl ?? '',
                    placeholder: (_, __) => const PhotoPlaceHolder(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user.name ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 16),
                  const Spacer(),
                  Text(
                    user.company ?? "",
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
