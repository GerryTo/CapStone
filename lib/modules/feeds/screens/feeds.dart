import 'package:capstone/modules/feeds/viewmodel/feeds_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/modules/feeds/widgets/card_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feeds extends StatelessWidget {
  const Feeds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gazebo"),
        centerTitle: true,
      ),
      body: Consumer<FeedsViewModel>(
        builder: (context, viewModel, child) {
          final feeds = viewModel.feeds;
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
