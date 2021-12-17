import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:capstone/modules/comment/viewmodel/comment_viewmodel.dart';
import 'package:capstone/modules/comment/widget/add_comment_button.dart';
import 'package:capstone/modules/comment/widget/comment_bottom_sheet.dart';
import 'package:capstone/modules/comment/widget/comment_list_item.dart';
import 'package:capstone/routes/routes.dart';
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Komentar',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Consumer<CurrentUserInfo>(
                      builder: (context, userInfo, _) {
                        return AddCommentButton(onPress: () {
                          if (userInfo.id == null) {
                            Routes.router.navigateTo(context, Routes.login);
                            return;
                          }
                          showBottomSheet(
                            context: context,
                            elevation: 10,
                            builder: (_) => CommentBottomSheet(viewModel),
                          );
                        });
                      },
                    ),
                  ],
                ),
                Expanded(child: _commentList(viewModel.comments)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _commentList(List<UserComment> comments) {
    if (comments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          'Belum Ada Komentar',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (_, index) {
        final comment = comments[index];
        return CommentListItem(comment);
      },
    );
  }
}
