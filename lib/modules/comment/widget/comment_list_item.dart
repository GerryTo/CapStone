import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:capstone/modules/comment/widget/comment_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CommentAvatar(userInfo.avatarUrl),
                title: Text(userInfo.name ?? '',
                    style: GoogleFonts.quicksand(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                subtitle: Text(
                  comment.body ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
