import 'dart:developer';
import 'dart:io';

import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum AddFeedStatus { init, loading, success, fail }

class AddFeedPageViewModel extends ChangeNotifier {
  var status = AddFeedStatus.init;
  final storage = firebase_storage.FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final CurrentUserInfo currentUserInfo;

  AddFeedPageViewModel(this.currentUserInfo) : super();

  Future<List<String>> uploadImages(List<XFile> files) {
    final userEmail = currentUserInfo.email;
    return Future.wait(files.map((file) async {
      final task = await storage
          .ref('gambar-feed/$userEmail-${file.name}')
          .putFile(File(file.path));
      return await task.ref.getDownloadURL();
    }));
  }

  Future send({
    required String title,
    required String description,
    required int? price,
    required List<XFile> files,
    required int? landArea,
    required String location,
  }) async {
    try {
      status = AddFeedStatus.loading;
      notifyListeners();
      final imageURLs = await uploadImages(files);
      final userRef = currentUserInfo.userRef;
      log('USER REF : ${userRef?.id}');

      final feed = Feed(
        title: title,
        description: description,
        images: imageURLs,
        userReference: userRef,
        timestamp: Timestamp.now(),
        price: price,
        landArea: landArea,
        location: location,
      ).toMap();
      //store the new project entity
      final project = await firestore.collection('projects').add(feed);
      //update user entity to include new project
      final res = firestore.collection('users').doc(userRef?.id).update({
        'projects': FieldValue.arrayUnion([project])
      });
      res.whenComplete(() {
        status = AddFeedStatus.success;
        notifyListeners();
      });
    } catch (e, s) {
      log('ADD_FEED_PAGE', error: e, stackTrace: s);
      status = AddFeedStatus.fail;
      notifyListeners();
    }
  }
}
