import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:flutter/material.dart';

class CardFeedPhoto extends StatelessWidget {
  const CardFeedPhoto(this.photo, {Key? key}) : super(key: key);
  final String? photo;
  @override
  Widget build(BuildContext context) {
    // final photoUrl = feed.images?.first;
    if (photo == null) {
      return const PhotoPlaceHolder();
    } else {
      return CachedNetworkImage(
        memCacheWidth: 1080,
        imageUrl: photo!,
        placeholder: (context, url) => const PhotoPlaceHolder(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }
  }
}
