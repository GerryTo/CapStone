import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:capstone/modules/comment/viewmodel/comment_viewmodel.dart';
import 'package:capstone/modules/comment/widget/add_comment_button.dart';
import 'package:capstone/modules/comment/widget/comment_bottom_sheet.dart';
import 'package:capstone/modules/comment/widget/comment_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(this.projectRef, {Key? key}) : super(key: key);
  final DocumentReference projectRef;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentViewModel(
        projectRef,
        context.read<CurrentUserInfo>().userRef,
      ),
      child: Consumer<CommentViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              AddCommentButton(onPress: () {
                showBottomSheet(
                  context: context,
                  elevation: 10,
                  builder: (_) => CommentBottomSheet(viewModel),
                );
              }),
              Expanded(child: _commentList(viewModel.comments)),
            ],
          );
        },
      ),
    );
  }

  ListView _commentList(List<UserComment> comments) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (_, index) {
        final comment = comments[index];
        return CommentListItem(comment);
      },
    );
  }
}
