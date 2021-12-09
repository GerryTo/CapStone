import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/viewmodel/comment_viewmodel.dart';
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
      builder: (ctx, __) {
        final comments = ctx.watch<CommentViewModel>().comments;
        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (_, index) {
            final comment = comments[index];
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(comment.body ?? 'asu'),
            );
          },
        );
      },
    );
  }
}
