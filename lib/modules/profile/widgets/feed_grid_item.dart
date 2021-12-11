import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedGridItem extends StatelessWidget {
  const FeedGridItem(this.project, {Key? key}) : super(key: key);
  final DocumentReference project;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: project.get(),
      builder: (context, snapshot) {
        // if (snapshot.hasError) {
        //   return Image.network(
        //       'https://via.placeholder.com/300x300.webp?text=Error',
        //       fit: BoxFit.cover);
        // }

        // if (snapshot.hasData && !snapshot.data!.exists) {
        //   return Image.network(
        //       'https://via.placeholder.com/300x300.webp?text=No+Data',
        //       fit: BoxFit.cover);
        // }

        if (snapshot.hasData) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          final imageUrl = (data?['images'] as List?)?.first as String?;
          if (imageUrl == null) {
            return Container(
              color: Colors.grey,
            );
          }
          return CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (_, __) => const PhotoPlaceHolder(),
              fit: BoxFit.cover);
        }

        return const PhotoPlaceHolder();
      },
    );
  }
}
