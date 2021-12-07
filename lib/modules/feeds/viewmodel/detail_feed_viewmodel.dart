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
    final snapshot = await firestore
        .collection("favorites")
        .doc(userRef.id + projectRef.id)
        .get();

    return snapshot.exists;
  }

  Future<void> toggleFavorite() async {
    final isFavorite = await _getFavoriteData();
    if (isFavorite) {
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
  }

  Future<void> checkFavorite() async {
    isFavorite = await _getFavoriteData();
    notifyListeners();
  }
}
