import 'dart:developer';

import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<Feed> favorites = [];
  final DocumentReference? userRef;
  final favoriteCollection = FirebaseFirestore.instance.collection('favorites');
  static const tag = 'FavoriteViewModel';

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
      log(docs.toString(), name: tag);
      for (final doc in docs) {
        log('fetch individual project', name: tag);
        final DocumentReference projectRef = doc.data()['project'];
        final projectSnapshot = await projectRef.get();
        final projectData = projectSnapshot.data() as Map<String, dynamic>?;
        if (projectData == null) continue;
        final project =
            Feed.fromMap(projectData).copyWith(ref: projectSnapshot.reference);
        log(project.toString(), name: tag);
        favorites.add(project);
      }
    } on Exception catch (e) {
      log(e.toString(), name: tag);
    } finally {
      notifyListeners();
    }
  }
}
