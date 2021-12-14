import 'dart:developer';
import 'package:capstone/modules/comment/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentViewModel extends ChangeNotifier {
  final List<UserComment> comments = [];
  final DocumentReference projectRef;
  final DocumentReference? userRef;

  CommentViewModel(this.projectRef, this.userRef) {
    getComments();
  }

  Future<void> getComments() async {
    log('Get Comment', name: 'CommentViewModel');
    try {
      final querySnapshot = await projectRef
          .collection('comments')
          .orderBy(
            'timestamp',
            descending: true,
          )
          .get();
      final commentsSnapshot = querySnapshot.docs;
      if (commentsSnapshot.isEmpty) {
        log('Comment Empty', name: 'CommentViewModel');
        return;
      }
      final comments = commentsSnapshot.map((e) {
        final data = e.data();

        final comment = UserComment.fromMap(data);
        return comment;
      }).toList();
      this.comments.clear();
      this.comments.addAll(comments);
    } on Exception catch (e, s) {
      log('CommentViewModel', error: e, stackTrace: s);
    }
  }

  Future<void> addComment(String body) async {
    try {
      if (body.isEmpty) return;
      final comment = UserComment(
        body: body,
        user: userRef,
        timestamp: Timestamp.now(),
      );

      await projectRef.collection('comments').add(comment.toMap());
    } on Exception catch (e, s) {
      log('CommentViewModel', error: e, stackTrace: s);
    }
  }
}
