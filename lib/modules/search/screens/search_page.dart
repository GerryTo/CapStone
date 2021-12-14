import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/modules/search/widgets/search_result.dart';
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: InputBorder.none,
                            hintText: 'Cari Proyek',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Consumer<SearchViewModel>(
                        builder: (context, viewModel, _) {
                          return ElevatedButton(
                            onPressed: () {
                              viewModel.search(_searchController.text);
                            },
                            child: const Icon(
                              Icons.search,
                              size: 32,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SearchResult()
            ],
          ),
        ),
      ),
    );
  }
}
