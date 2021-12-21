import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'feed_grid_item.dart';

class ProfileFeedGrid extends StatelessWidget {
  const ProfileFeedGrid(this.projects, {Key? key}) : super(key: key);
  final List<DocumentReference<Object?>>? projects;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
      ),
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(5),
      itemCount: projects?.length,
      itemBuilder: (context, index) {
        final project = projects?[index];
        if (project == null) {
          return Container();
        }
        return GestureDetector(
          onTap: () => Routes.router.navigateTo(
            context,
            Routes.detailFeed,
            routeSettings: RouteSettings(
              arguments: project,
            ),
          ),
          child: FeedGridItem(project),
        );
      },
    );
  }
}
