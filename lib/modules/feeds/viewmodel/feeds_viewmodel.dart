import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FeedsViewModel extends ChangeNotifier {
  Status status = Status.loading;
  final firestore = FirebaseFirestore.instance;
  final List<Feed> feeds = [];
  FeedsViewModel() {
    getFeeds();
  }

  Future<void> getFeeds() async {
    try {
      this.feeds.clear();
      final snap = await firestore
          .collection('projects')
          .orderBy('timestamp', descending: true)
          .get();
      final feeds = snap.docs.map((doc) {
        final data = doc.data();
        data['ref'] = doc.reference;
        return Feed.fromMap(data);
      }).toList();

      this.feeds.addAll(feeds);
      status = Status.success;
      notifyListeners();
    } on Exception catch (_) {
      status = Status.fail;
    }
  }
}
