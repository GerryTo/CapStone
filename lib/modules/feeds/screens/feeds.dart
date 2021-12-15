import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/feeds/viewmodel/feeds_viewmodel.dart';
import 'package:capstone/modules/search/screens/search_page.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/modules/feeds/widgets/card_feed.dart';
import 'package:capstone/widget/loading_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Feeds extends StatelessWidget {
  const Feeds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Routes.router.navigateTo(context, Routes.search);
          //   },
          //   icon: const Icon(Icons.search),
          // ),
          IconButton(
            onPressed: () {
              Routes.router.navigateTo(context, Routes.settings);
            },
            icon: const Icon(Icons.menu),
          ),
        ],
        title: Text(
          "Gazebo",
          style: GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Consumer<FeedsViewModel>(
        builder: (context, viewModel, child) {
          final feeds = viewModel.feeds;
          if (viewModel.status == Status.loading) {
            return ListView(
              children: List.generate(3, (_) => const LoadingCard()),
            );
          }
          return RefreshIndicator(
            onRefresh: () => viewModel.getFeeds(),
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(
                feeds.length,
                (index) => GestureDetector(
                  onTap: () {
                    Routes.router.navigateTo(
                      context,
                      Routes.detailFeed,
                      routeSettings: RouteSettings(arguments: feeds[index].ref),
                    );
                  },
                  child: CardFeed(feeds[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
