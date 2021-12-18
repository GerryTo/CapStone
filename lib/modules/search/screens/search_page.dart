import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
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

class SearchBar extends StatelessWidget {
  SearchBar({
    required this.searchController,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final TextEditingController searchController;
  final void Function() onSubmit;
  final _landAreaController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                border: InputBorder.none,
                hintText: 'Nama proyek, Luas tanah, atau lain lainnya ',
                hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          TextButton.icon(
            onPressed: () {
              // context.read<SearchViewModel>().landArea = 36;
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _landAreaController,
                          decoration: const InputDecoration(
                              labelText: 'Luas tanah',
                              suffix: Text('m2'),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                      ],
                    ),
                  ));
                },
              ).then((value) => context.read<SearchViewModel>().landArea =
                  int.tryParse(_landAreaController.text));
            },
            icon: const Icon(
              Icons.filter_alt,
              size: 24,
            ),
            label: const Text('Filter'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(right: 8),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: onSubmit,
              icon: const Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ),
              // padding: EdgeInsets.zero,
              // constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
