import 'dart:developer';

import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DetailFeedViewModel extends ChangeNotifier {
  final DocumentReference projectRef;
  final DocumentReference userRef;
  final firestore = FirebaseFirestore.instance;
  bool isFavorite = false;
  User? user;
  Feed? feed;

  DetailFeedViewModel(this.projectRef, this.userRef) {
    checkFavorite();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final projectData =
          await firestore.collection('projects').doc(projectRef.id).get();
      notifyListeners();
      feed = Feed.fromMap(projectData.data() as Map<String, dynamic>);
      notifyListeners();
      final userData = await firestore
          .collection('users')
          .doc(feed?.userReference?.id)
          .get();
      user = User.fromMap(userData.data() as Map<String, dynamic>);
      notifyListeners();
    } on Exception catch (e, s) {
      log('ERROR', name: 'detail_feed_viewmodel', error: e, stackTrace: s);
    }
  }

  Future<bool> _getFavoriteData() async {
    try {
      final snapshot = await firestore
          .collection("favorites")
          .doc(userRef.id + projectRef.id)
          .get();

      return snapshot.exists;
    } on Exception catch (e, s) {
      log('ERROR', name: 'detail_feed_viewmodel', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> toggleFavorite() async {
    try {
      final isFavorite = await _getFavoriteData();
      log(isFavorite.toString());
      if (!isFavorite) {
        await firestore
            .collection("favorites")
            .doc(userRef.id + projectRef.id)
            .set({
          "user": userRef,
          "project": projectRef,
        });
      } else {
        await firestore
            .collection("favorites")
            .doc(userRef.id + projectRef.id)
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
