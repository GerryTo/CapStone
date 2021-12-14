import 'dart:developer';

import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum EditFeedStatus { init, loading, success, fail }

class EditFeedProfileKuViewModel extends ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  String ref;
  Feed? feed;
  final String currentUserId;
  var status = EditFeedStatus.init;

  EditFeedProfileKuViewModel({required this.ref, required this.currentUserId}) {
    fetchData(ref);
  }

  Future<void> fetchData(String ref) async {
    try {
      status = EditFeedStatus.loading;
      notifyListeners();
      final data = await fireStore.collection('projects').doc(ref).get();
      feed = Feed.fromMap(data.data() as Map<String, dynamic>);
      status = EditFeedStatus.success;
      notifyListeners();
    } catch (e, s) {
      log('FETCH_DATA', error: e, stackTrace: s);
      status = EditFeedStatus.fail;
      notifyListeners();
    }
  }

  Future<void> deleteFeed() async {
    try {
      status = EditFeedStatus.loading;
      notifyListeners();
      fireStore.collection('projects').doc(ref).delete();
      final projectRef = fireStore.collection('projects').doc(ref);
      fireStore.collection('users').doc(currentUserId).update({
        "projects": FieldValue.arrayRemove([projectRef])
      });
      status = EditFeedStatus.success;
      notifyListeners();
    } catch (e, s) {
      log('DELETE_FEED', error: e, stackTrace: s);
      status = EditFeedStatus.fail;
      notifyListeners();
    }
  }

  Future<void> editFeed(String ref, String? newTitle, String? newDesc, int? newPrice) async {
    try {
      fireStore
          .collection('projects')
          .doc(ref)
          .update({"title": newTitle, "description": newDesc, "price":newPrice});
    } catch (e, s) {
      log('EDIT_FEED', error: e, stackTrace: s);
      status = EditFeedStatus.fail;
      notifyListeners();
    }
  }
}
