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
  String dataSearch = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                              hintText:
                                  'Nama proyek, Luas tanah, atau lain lainnya ',
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
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
                                setState(() {
                                  dataSearch = _searchController.text;
                                  viewModel.search(_searchController.text);
                                });
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
                if (dataSearch.isEmpty || dataSearch == '')
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                              'assets/search.svg',
                              width: 300,
                              height: 300,
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06),
                        const Text(
                          'Kamu mau cari apa nih ?',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        //
                      ],
                    ),
                  )
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
