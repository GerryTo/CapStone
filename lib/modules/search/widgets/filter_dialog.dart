import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    Key? key,
    required TextEditingController landAreaController,
  })  : _landAreaController = landAreaController,
        super(key: key);

  final TextEditingController _landAreaController;

  @override
  Widget build(BuildContext context) {
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
