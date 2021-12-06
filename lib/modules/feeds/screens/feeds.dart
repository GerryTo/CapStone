import 'package:capstone/modules/feeds/viewmodel/feeds_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:capstone/widget/card_feed.dart';
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
      body: ChangeNotifierProvider(
        create: (_) => FeedsViewModel(),
        builder: (context, _) {
          final feeds = context.watch<FeedsViewModel>().feeds;
          return ListView(
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
                  child: CardFeed(feeds[index])),
            ),
          );
        },
      ),
    );
  }
}
