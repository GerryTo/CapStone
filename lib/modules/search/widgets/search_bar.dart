import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/modules/search/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final void Function() onSubmit;

  const SearchBar({
    required this.searchController,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        border: Border.all(color: Theme.of(context).focusColor),
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
          Builder(builder: (context) {
            return TextButton.icon(
              onPressed: () {
                final searchViewModel =
                    Provider.of<SearchViewModel>(context, listen: false);
                showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: searchViewModel,
                      child: FilterDialog(),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.filter_alt,
                size: 24,
              ),
              label: const Text('Filter'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(right: 8),
              ),
            );
          }),
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
