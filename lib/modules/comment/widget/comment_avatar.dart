import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentAvatar extends StatelessWidget {
  const CommentAvatar(this.avatarUrl, {Key? key}) : super(key: key);
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null) {
      return const Icon(
        Icons.person,
        size: 32,
      );
    } else {
      return CachedNetworkImage(
        width: 32,
        height: 32,
        fit: BoxFit.cover,
        imageUrl: avatarUrl!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}
