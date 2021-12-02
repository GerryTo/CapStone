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
        if (snapshot.hasError) {
          return Image.network(
              'https://via.placeholder.com/300x300.webp?text=Error');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Image.network(
              'https://via.placeholder.com/300x300.webp?text=No+Data');
        }

        if (snapshot.hasData) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          return GestureDetector(
              onTap: () =>
                  Routes.router.navigateTo(context, Routes.detailFeedProfilKu),
              child: Image.network((data?['images'] as List?)?.first ??
                  'https://via.placeholder.com/300x300.webp?text=No+Pic'));
        }

        return Image.network(
            'https://via.placeholder.com/300x300.webp?text=Loading');
      },
    );
  }
}
