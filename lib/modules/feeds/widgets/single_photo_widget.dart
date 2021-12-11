import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SinglePhotoWidget extends StatelessWidget {
  const SinglePhotoWidget({this.photo, Key? key}) : super(key: key);
  final String? photo;

  @override
  Widget build(BuildContext context) {
    if (photo == null) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: photo!,
        placeholder: (context, url) => Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          child: const CircularProgressIndicator(),
        ),
      );
    }
  }
}
