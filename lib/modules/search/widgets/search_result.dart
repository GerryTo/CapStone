import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, viewModel, _) {
      final projects = viewModel.projects;

      if (viewModel.status == Status.loading) {
        return const CircularProgressIndicator();
      }

      if (viewModel.status == Status.noData) {
        return const Center(child: Text('Tidak ditemukan'));
      }

      if (viewModel.status == Status.fail) {
        return const Center(child: Text('Terjadi kegagalan mencari proyek'));
      }

      return Expanded(
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () => Routes.router.navigateTo(
                  context,
                  Routes.detailFeed,
                  routeSettings: RouteSettings(arguments: projects[index].ref),
                ),
                title: Text(projects[index].title ?? 'no title'),
                subtitle: Text(
                  _cutText(projects[index].description ?? ''),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  String _cutText(String text) {
    if (text.length > 75) {
      return text.substring(0, 75);
    }
    return text;
  }
}
