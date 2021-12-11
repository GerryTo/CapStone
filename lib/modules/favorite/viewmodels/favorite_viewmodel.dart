import 'dart:developer';

import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<Feed> favorites = [];
  final DocumentReference? userRef;
  final favoriteCollection = FirebaseFirestore.instance.collection('favorites');
  static const tag = 'FavoriteViewModel';
  Status status = Status.loading;

  FavoriteViewModel(this.userRef) {
    getFavorites();
  }

  Future<void> getFavorites() async {
    log('Get Favorite', name: tag);
    favorites.clear();
    try {
      final snapshot =
          await favoriteCollection.where("user", isEqualTo: userRef).get();
      final docs = snapshot.docs;

      final job =
          await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(
              docs, (doc) async {
        final DocumentReference projectRef = doc.data()['project'];
        final projectSnapshot = await projectRef.get();
        final projectData = projectSnapshot.data() as Map<String, dynamic>?;
        if (projectData == null) return;
        final project =
            Feed.fromMap(projectData).copyWith(ref: projectSnapshot.reference);
        log(project.toString(), name: tag);
        favorites.add(project);
      });
      if (job == null) {
        status = Status.success;
      }
    } on Exception catch (e) {
      status = Status.fail;
      log(e.toString(), name: tag);
    } finally {
      notifyListeners();
    }
  }
}
