import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:capstone/widget/card_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteViewModel(context.read<CurrentUserInfo>().userRef),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorit'),
        ),
        body: Consumer<FavoriteViewModel>(
          builder: (context, viewmodel, _) {
            return ListView.builder(
              itemCount: viewmodel.favorites.length,
              itemBuilder: (context, index) {
                return CardFeed(viewmodel.favorites[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
