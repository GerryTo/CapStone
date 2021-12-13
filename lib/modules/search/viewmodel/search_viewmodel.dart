import 'package:algolia/algolia.dart';
import 'package:capstone/config/app_search.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// User bisa mencari berdasarkan:
/// 1. judul
/// User bisa memfilter berdasarkan
/// 1. harga
///

class SearchViewModel extends ChangeNotifier {
  final algolia = AppSearch.algolia;
  final List<Feed> projects = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void search(String text) async {
    final query = algolia.instance.index('capstone_sib').query(text);
    final AlgoliaQuerySnapshot snap = await query.getObjects();
    if (snap.hasHits) {
      final hits = snap.hits;
      final List<Feed> projects = hits.map((hit) {
        var project = Feed.fromMap(hit.data);
        //tambahkan reference ke objek project
        project = project.copyWith(
            ref: firestore.collection('projects').doc(hit.objectID));
        return project;
      }).toList();

      this.projects.clear();
      this.projects.addAll(projects);
      notifyListeners();
    }
  }
}
