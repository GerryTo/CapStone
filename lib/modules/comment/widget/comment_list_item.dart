import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:capstone/modules/comment/widget/comment_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem(this.comment, {Key? key}) : super(key: key);
  final UserComment comment;
  @override
  Widget build(BuildContext context) {
    final user = comment.user;
    if (user == null) return Container();
    return FutureBuilder<DocumentSnapshot>(
      future: user.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          if (data == null) return Container();
          final userInfo = User.fromMap(data);

          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CommentAvatar(userInfo.avatarUrl),
            title: Text(userInfo.name ?? ''),
            subtitle: Text(comment.body ?? ''),
          );
        }
        return Container();
      },
    );
  }
}
