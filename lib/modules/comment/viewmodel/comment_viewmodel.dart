import 'dart:developer';
import 'dart:html';

import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentViewModel extends ChangeNotifier {
  final List<UserComment> comments = [];
  final DocumentReference projectRef;
  final CurrentUserInfo userInfo;

  CommentViewModel(this.projectRef, this.userInfo) {
    getComments();
  }

  void getComments() async {
    try {
      final querySnapshot = await projectRef.collection('comments').get();
      final commentsSnapshot = querySnapshot.docs;

      commentsSnapshot.map((e) {
        final comment = UserComment.fromMap(e.data());
        comments.add(comment);
      });
    } on Exception catch (e, s) {
      log('CommentViewModel', error: e, stackTrace: s);
    }
  }

  void addComment(String body) async {
    try {
      if (body.isEmpty) return;

      final comment = UserComment(
        body: body,
        user: userInfo.userRef,
        timestamp: Timestamp.now(),
      );

      final res = await projectRef.collection('comments').add(comment.toMap());
    } on Exception catch (e, s) {
      log('CommentViewModel', error: e, stackTrace: s);
    }
  }
}
