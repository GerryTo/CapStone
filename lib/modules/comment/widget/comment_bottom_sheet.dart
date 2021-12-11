import 'package:capstone/modules/comment/viewmodel/comment_viewmodel.dart';
import 'package:flutter/material.dart';

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet(this.viewModel, {Key? key}) : super(key: key);
  final CommentViewModel viewModel;
  final _commentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
      enableDrag: false,
      onClosing: () => viewModel.getComments(),
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(label: Text('Isi komentar')),
                controller: _commentTextController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.addComment(_commentTextController.text);
                await viewModel
                    .getComments()
                    .then((_) => Navigator.of(context).pop());
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }
}
