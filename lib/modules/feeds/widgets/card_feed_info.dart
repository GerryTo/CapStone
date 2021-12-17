import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/card_feed_info_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardFeedInfo extends StatelessWidget {
  CardFeedInfo({
    required this.feed,
    required this.onProfileTap,
    Key? key,
  }) : super(key: key);

  final Feed feed;
  final void Function() onProfileTap;
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

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
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      feed.title!.length > 10
                          ? feed.title!.substring(0, 14) + '...'
                          : feed.title ?? '',
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formatCurrency.format(feed.price ?? 0),
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
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
                      style: const TextStyle(
                          fontSize: 16, fontFamily: 'ReadexPro'),
                    ),
                    const SizedBox(width: 16),
                    const Spacer(),
                    Text(
                      user.company ?? "",
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'ReadexPro'),
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
