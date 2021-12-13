import 'package:capstone/modules/feeds/widgets/card_feed.dart';
import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(controller: _searchController),
                  ),
                  Consumer<SearchViewModel>(
                    builder: (context, viewModel, _) {
                      return ElevatedButton(
                        onPressed: () {
                          viewModel.search(_searchController.text);
                        },
                        child: const Icon(Icons.arrow_right),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child:
                    Consumer<SearchViewModel>(builder: (context, viewModel, _) {
                  final projects = viewModel.projects;
                  return ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () => Routes.router.navigateTo(
                            context,
                            Routes.detailFeed,
                            routeSettings:
                                RouteSettings(arguments: projects[index].ref),
                          ),
                          title: Text(projects[index].title ?? 'no title'),
                          subtitle: Text(
                            _cutText(projects[index].description ?? ''),
                          ),
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
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
