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
              children: [
                Consumer<SearchViewModel>(
                  builder: (context, viewModel, _) {
                    return SearchBar(
                      searchController: _searchController,
                      onSubmit: () {
                        setState(
                          () {
                            viewModel.search(_searchController.text, 36);
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                if (_searchController.text.isEmpty)
                  const EmptySearchQuery()
                else
                  const SearchResult()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptySearchQuery extends StatelessWidget {
  const EmptySearchQuery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.4,
            child: SvgPicture.asset(
              'assets/search.svg',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kamu mau cari apa nih ?',
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontFamily: 'ReadexPro'),
            textAlign: TextAlign.center,
          ),
          //
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    required this.searchController,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final TextEditingController searchController;
  final void Function() onSubmit;

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
            onPressed: () {},
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
