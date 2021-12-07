import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DetailFeedViewModel extends ChangeNotifier {
  final DocumentReference projectRef;
  final DocumentReference userRef;
  final firestore = FirebaseFirestore.instance;
  bool isFavorite = false;

  DetailFeedViewModel(this.projectRef, this.userRef) {
    checkFavorite();
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
      return false;
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
    isFavorite = await _getFavoriteData();
    notifyListeners();
  }
}
