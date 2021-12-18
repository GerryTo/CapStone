import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({
    Key? key,
  }) : super(key: key);

  final _landAreaController = TextEditingController();

  final _maxPriceController = TextEditingController();

  final _minPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SearchViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _landAreaController,
                    decoration: const InputDecoration(
                      labelText: 'Luas tanah',
                      suffix: Text('m2'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _maxPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Harga Tertinggi',
                      prefix: Text('Rp. '),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _minPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Harga Terrendah',
                      prefix: Text('Rp. '),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(32),
                    ),
                    onPressed: () {
                      viewModel.landArea =
                          int.tryParse(_landAreaController.text);
                      viewModel.maxPrice =
                          int.tryParse(_maxPriceController.text);
                      viewModel.minPrice =
                          int.tryParse(_minPriceController.text);
                    },
                    child: const Text('Simpan Filter'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
