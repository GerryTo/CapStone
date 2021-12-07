import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<Feed> favorites = [];
  final DocumentReference? userRef;
  final favoriteCollection = FirebaseFirestore.instance.collection('favorites');

  FavoriteViewModel(this.userRef);

  Future<void> getFavorites() async {
    final data =
        await favoriteCollection.where("user", isEqualTo: userRef).get();
    favorites = data.docs.map((doc) {
      return Feed.fromMap(doc.data());
    }).toList();
    notifyListeners();
  }
}
