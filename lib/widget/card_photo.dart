import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPhoto extends StatelessWidget {
  CardPhoto(this.photoUrl, {Key? key}) : super(key: key);
  String photoUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
      placeholder: (_, __) => const PhotoPlaceHolder(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
