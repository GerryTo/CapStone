import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:flutter/material.dart';

class CardFeedInfoAvatar extends StatelessWidget {
  const CardFeedInfoAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null) {
      return const Icon(Icons.person, size: 32);
    }
    return CachedNetworkImage(
      height: 32,
      width: 32,
      memCacheHeight: 96,
      memCacheWidth: 96,
      imageUrl: avatarUrl!,
      placeholder: (_, __) => const Icon(Icons.person, size: 32),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.fitHeight,
    );
  }
}
