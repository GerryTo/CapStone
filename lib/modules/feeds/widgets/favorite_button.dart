import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget{
  FavoriteButton( {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {},
      child: Consumer<DetailFeedViewModel>(
          builder: (context, viewmodel, _) {
            return IconButton(
              icon: Icon(
                  viewmodel.isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_outline_rounded,
                  color: Colors.black),
              onPressed: () {
                viewmodel.toggleFavorite();
              },
            );
          }),
    );
  }

}