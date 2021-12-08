import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:capstone/routes/routes.dart';
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
          return GestureDetector(
            onTap: () => Routes.router.navigateTo(context, Routes.detailFeed,
                routeSettings: RouteSettings(arguments: project)),
            child: CachedNetworkImage(
                imageUrl: (data?['images'] as List?)?.first ??
                    'https://via.placeholder.com/300x300.webp?text=No+Pic',
                placeholder: (_, __) => const PhotoPlaceHolder(),
                fit: BoxFit.cover),
          );
        }

        return const PhotoPlaceHolder();
      },
    );
  }
}
