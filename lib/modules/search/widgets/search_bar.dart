import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/modules/search/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final void Function() onSubmit;

  const SearchBar({
    required this.searchController,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _landAreaController = TextEditingController();

  final _maxPriceController = TextEditingController();

  final _minPriceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _landAreaController.dispose();
    _maxPriceController.dispose();
    _minPriceController.dispose();
  }

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
              controller: widget.searchController,
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
                  return FilterDialog(landAreaController: _landAreaController);
                },
              ).then((value) {
                return context.read<SearchViewModel>().landArea =
                    int.tryParse(_landAreaController.text);
              });
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
              onPressed: widget.onSubmit,
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
