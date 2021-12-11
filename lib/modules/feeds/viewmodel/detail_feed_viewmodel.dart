import 'dart:developer';

import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DetailFeedViewModel extends ChangeNotifier {
  final DocumentReference projectRef;
  final DocumentReference? userRef;
  final firestore = FirebaseFirestore.instance;
  bool isFavorite = false;
  User? user;
  Feed? project;

  DetailFeedViewModel(this.projectRef, this.userRef) {
    _init();
  }

  void _init() async {
    await _getFeedData();
    await _getUserData();
    await checkFavorite();
  }

  Future<void> _getFeedData() async {
    final projectData =
        await firestore.collection('projects').doc(projectRef.id).get();
    project = Feed.fromMap(projectData.data() as Map<String, dynamic>);
    notifyListeners();
  }

  Future<void> _getUserData() async {
    try {
      final userData = await firestore
          .collection('users')
          .doc(project?.userReference?.id)
          .get();
      user = User.fromMap(userData.data() as Map<String, dynamic>);
      notifyListeners();
    } on Exception catch (e, s) {
      log('ERROR', name: 'detail_feed_viewmodel', error: e, stackTrace: s);
    }
  }

  Future<bool> _getFavoriteData() async {
    try {
      final userId = userRef?.id;
      if (userId != null) {
        final snapshot = await firestore
            .collection("favorites")
            .doc(userId + projectRef.id)
            .get();
        return snapshot.exists;
      } else {
        throw Exception('Can\'t get favorite data');
      }
    } on Exception catch (e, s) {
      log('ERROR', name: 'detail_feed_viewmodel', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> toggleFavorite() async {
    try {
      final isFavorite = await _getFavoriteData();
      final userId = userRef?.id;
      if (userId == null) return;
      if (!isFavorite) {
        await firestore
            .collection("favorites")
            .doc(userId + projectRef.id)
            .set({
          "user": userRef,
          "project": projectRef,
        });
      } else {
        await firestore
            .collection("favorites")
            .doc(userId + projectRef.id)
            .delete();
      }
      await checkFavorite();
    } on Exception catch (e, s) {
      log('ERROR', name: 'detail_feed_viewmodel', error: e, stackTrace: s);
    }
  }

  Future<void> checkFavorite() async {
    try {
      isFavorite = await _getFavoriteData();
      notifyListeners();
    } on Exception catch (e) {
      isFavorite = false;
    }
  }
}
