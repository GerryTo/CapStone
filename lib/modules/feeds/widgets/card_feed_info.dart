import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/card_feed_info_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardFeedInfo extends StatelessWidget {
  const CardFeedInfo({
    required this.feed,
    required this.onProfileTap,
    Key? key,
  }) : super(key: key);

  final Feed feed;
  final void Function() onProfileTap;
  @override
  Widget build(BuildContext context) {
    final userRef = feed.userReference;
    return FutureBuilder<DocumentSnapshot>(
      future: userRef?.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null) return Container();
          final user = User.fromMap(data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feed.title ?? "",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onProfileTap,
                child: Row(
                  children: [
                    CardFeedInfoAvatar(avatarUrl: user.avatarUrl),
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
