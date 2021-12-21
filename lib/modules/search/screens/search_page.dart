import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/modules/search/widgets/search_bar.dart';
import 'package:capstone/modules/search/widgets/search_result.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          title: Text(
            'Search',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Routes.router.navigateTo(context, Routes.settings);
              },
              icon: const Icon(Icons.menu),
            ),
          ],
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
                    final maxPrice = viewModel.maxPrice;
                    final minPrice = viewModel.minPrice;

                    return Wrap(
                      children: [
                        (landArea != null)
                            ? Chip(
                                label: Text('Luas Tanah $landArea'),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  viewModel.landArea = null;
                                },
                              )
                            : const SizedBox.shrink(),
                        (minPrice != null)
                            ? Chip(
                                label: Text('Harga Terrendah $minPrice'),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  viewModel.minPrice = null;
                                },
                              )
                            : const SizedBox.shrink(),
                        (maxPrice != null)
                            ? Chip(
                                label: Text('Luas Tanah $maxPrice'),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  viewModel.maxPrice = null;
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
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
