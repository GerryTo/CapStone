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

  bool _disposed = false;

  FavoriteViewModel(this.userRef) {
    getFavorites();
  }

  /// https://stackoverflow.com/questions/63884633/unhandled-exception-a-changenotifier-was-used-after-being-disposed
  /// favorite viewmodel lama dalam mengambil data. sehingga apabila user terlalu
  /// cepat berpindah halaman maka notifylistener dapat terpanggil sesudah changenotifier ini
  /// ter dispose
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<void> getFavorites() async {
    log('Get Favorite', name: tag);
    favorites.clear();
    try {
      final snapshot =
          await favoriteCollection.where("user", isEqualTo: userRef).get();
      final docs = snapshot.docs;

      await _fetchProjectData(docs);
      status = Status.success;
    } on Exception catch (e) {
      status = Status.fail;
      log(e.toString(), name: tag);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchProjectData(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    for (final doc in docs) {
      try {
        final DocumentReference projectRef = doc.data()['project'];
        final projectSnapshot = await projectRef.get();
        final projectData = projectSnapshot.data() as Map<String, dynamic>?;
        if (projectData == null) return;
        final project =
            Feed.fromMap(projectData).copyWith(ref: projectSnapshot.reference);
        log(project.toString(), name: tag);
        favorites.add(project);
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}
