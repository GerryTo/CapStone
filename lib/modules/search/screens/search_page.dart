import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/modules/search/widgets/filter_dialog.dart';
import 'package:capstone/modules/search/widgets/search_bar.dart';
import 'package:capstone/modules/search/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  return SearchBar(
                    searchController: _searchController,
                    onSubmit: () {
                      setState(
                        () {
                          context
                              .read<SearchViewModel>()
                              .search(_searchController.text);
                        },
                      );
                    },
                  );
                }),
                Consumer<SearchViewModel>(
                  builder: (context, viewModel, _) {
                    final landArea = viewModel.landArea;
                    if (landArea == null) return const SizedBox.shrink();
                    return Chip(
                      label: Text('Luas Tanah $landArea'),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        viewModel.landArea = null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SearchResult()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
