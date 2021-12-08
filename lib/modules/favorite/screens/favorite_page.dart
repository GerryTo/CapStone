import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
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
            return RefreshIndicator(
              onRefresh: () => viewmodel.getFavorites(),
              child: ListView.builder(
                itemCount: viewmodel.favorites.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Routes.router
                          .navigateTo(
                            context,
                            Routes.detailFeed,
                            routeSettings: RouteSettings(
                              arguments: viewmodel.favorites[index].ref,
                            ),
                          )
                          .then((value) => viewmodel.getFavorites());
                    },
                    child: CardFeed(viewmodel.favorites[index]),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
