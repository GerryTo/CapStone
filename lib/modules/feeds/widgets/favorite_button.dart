import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailFeedViewModel>(builder: (context, viewmodel, _) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).buttonTheme.colorScheme?.surface,
        child: Icon(Icons.favorite_rounded,
            color: viewmodel.isFavorite ? Colors.pink : Colors.grey),
        onPressed: () {
          viewmodel.toggleFavorite();
        },
      );
    });
  }
}
