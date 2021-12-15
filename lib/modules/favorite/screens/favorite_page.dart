import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/favorite/viewmodels/favorite_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/modules/feeds/widgets/card_feed.dart';
import 'package:capstone/widget/loading_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorit',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Consumer<FavoriteViewModel>(
        builder: (context, viewmodel, _) {
          if (viewmodel.status == Status.loading) {
            return ListView(
              children: List.generate(3, (index) => const LoadingCard()),
            );
          }
          return RefreshIndicator(
            onRefresh: () => viewmodel.getFavorites(),
            child: viewmodel.favorites.isNotEmpty
                ? _content(viewmodel)
                : _noContent(context),
          );
        },
      ),
    );
  }

  ListView _content(FavoriteViewModel viewmodel) {
    return ListView.builder(
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
    );
  }

  Widget _noContent(BuildContext context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Opacity(
              opacity: 0.4,
              child: SvgPicture.asset(
                'assets/favorite.svg',
                width: 300,
                height: 300,
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          const Text(
            'Sepertinya, belum ada yang kamu suka',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        ],
      ),
    );
  }
}
