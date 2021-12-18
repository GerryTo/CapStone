import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchResultItemPhoto extends StatelessWidget {
  const SearchResultItemPhoto({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const SizedBox.shrink();
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: 96,
      );
    }
  }
}
