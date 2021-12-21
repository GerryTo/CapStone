import 'package:algolia/algolia.dart';
import 'package:capstone/config/app_search.dart';
import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final algolia = AppSearch.algolia;
  final List<Feed> projects = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Status status = Status.init;

  int? _landArea;
  int? _minPrice;
  int? _maxPrice;

  set landArea(int? landArea) {
    _landArea = landArea;
    notifyListeners();
  }

  int? get landArea => _landArea;

  set maxPrice(int? maxPrice) {
    _maxPrice = maxPrice;
    notifyListeners();
  }

  int? get maxPrice => _maxPrice;

  set minPrice(int? minPrice) {
    _minPrice = minPrice;
    notifyListeners();
  }

  int? get minPrice => _minPrice;

  String _filterBuilder() {
    final List<String> filters = [];
    if (_landArea != null) {
      filters.add('landArea=$_landArea');
    }

    if (_maxPrice != null) {
      filters.add('price<=$_maxPrice');
    }

    if (_minPrice != null) {
      filters.add('price>=$_minPrice');
    }

    return filters.join(" AND ");
  }

  void search(String text) async {
    try {
      _loading();
      AlgoliaQuery query = algolia.instance.index('capstone_sib').query(text);

      final filters = _filterBuilder();
      if (filters.isNotEmpty) {
        query = query.filters(filters);
      }

      final AlgoliaQuerySnapshot snap = await query.getObjects();

      projects.clear();
      if (snap.hasHits) {
        final hits = snap.hits;
        final List<Feed> projects = hits.map((hit) {
          var project = Feed.fromMap(hit.data);
          //tambahkan reference ke objek project
          project = project.copyWith(
              ref: firestore.collection('projects').doc(hit.objectID));
          return project;
        }).toList();

        this.projects.addAll(projects);
        status = Status.success;
        notifyListeners();
      } else {
        _noData();
      }
    } on AlgoliaError {
      status = Status.fail;
      notifyListeners();
    } on Exception catch (_) {
      status = Status.fail;
      notifyListeners();
    }
  }

  void _loading() {
    status = Status.loading;
    notifyListeners();
  }

  void _noData() {
    status = Status.noData;
    notifyListeners();
  }
}
