import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<Feed> favorites = [];
  final DocumentReference? userRef;
  final favoriteCollection = FirebaseFirestore.instance.collection('favorites');

  FavoriteViewModel(this.userRef) {
    getFavorites();
  }

  Future<void> getFavorites() async {
    favorites.clear();
    final snapshot =
        await favoriteCollection.where("user", isEqualTo: userRef).get();
    final docs = snapshot.docs;
    for (final doc in docs) {
      final DocumentReference projectRef = doc.data()['project'];
      final projectSnapshot = await projectRef.get();
      final projectData = projectSnapshot.data() as Map<String, dynamic>;
      final project = Feed.fromMap(projectData);
      favorites.add(project);
      notifyListeners();
    }
  }
}
