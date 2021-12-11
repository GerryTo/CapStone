import 'package:flutter/material.dart';

class AddCommentButton extends StatelessWidget {
  const AddCommentButton({required this.onPress, Key? key}) : super(key: key);
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      icon: const Icon(Icons.comment),
      label: const Text('Tambahkan Komentar'),
    );
  }
}
