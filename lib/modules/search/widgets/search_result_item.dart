import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/search/widgets/search_result_item_photo.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Feed project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Routes.router.navigateTo(
        context,
        Routes.detailFeed,
        routeSettings: RouteSettings(arguments: project.ref),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchResultItemPhoto(imageUrl: project.images?.first),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title ?? 'no title',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    _cutText(
                      project.description ?? '',
                    ),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _cutText(String text) {
    if (text.length > 75) {
      return text.substring(0, 75);
    }
    return text;
  }
}
