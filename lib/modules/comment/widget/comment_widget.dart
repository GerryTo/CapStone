import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/model/comment.dart';
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
            return _commentItem(comment);
          },
        );
      },
    );
  }

  Widget _commentItem(UserComment comment) {
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
            leading: _avatar(userInfo),
            title: Text(userInfo.name ?? ''),
            subtitle: Text(comment.body ?? ''),
          );
        }
        return Container();
      },
    );
  }

  Widget _avatar(User userInfo) {
    final avatarUrl = userInfo.avatarUrl;
    if (avatarUrl == null) {
      return const Icon(
        Icons.person,
        size: 32,
      );
    }
    return CachedNetworkImage(
      width: 32,
      height: 32,
      fit: BoxFit.cover,
      imageUrl: avatarUrl,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
