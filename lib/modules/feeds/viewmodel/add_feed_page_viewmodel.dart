import 'dart:developer';
import 'dart:io';

import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum AddFeedStatus { init, loading, success, fail }

class AddFeedPageViewModel extends ChangeNotifier {
  var status = AddFeedStatus.init;
  final storage = firebase_storage.FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  String _getUserEmail() {
    return auth.currentUser?.email ?? '';
  }

  Future<DocumentReference> getUserRef() async {
    final snap = await firestore
        .collection('users')
        .where('email', isEqualTo: _getUserEmail())
        .get();
    return snap.docs.first.reference;
  }

  Future<List<String>> uploadImages(List<XFile> files) {
    return Future.wait(files.map((file) async {
      final task = await storage
          .ref('gambar-feed/${_getUserEmail()}-${file.name}')
          .putFile(File(file.path));
      return await task.ref.getDownloadURL();
    }));
  }

  Future send(
      {required String title,
      required String description,
      required List<XFile> files}) async {
    try {
      status = AddFeedStatus.loading;
      notifyListeners();
      final imageURLs = await uploadImages(files);
      final userRef = await getUserRef();
      log('USER REF : ${userRef.id}');

      final feed = Feed(
        title: title,
        description: description,
        images: imageURLs,
        userReference: userRef,
      ).toMap();
      //store the new project entity
      final project = await firestore.collection('projects').add(feed);
      //update user entity to include new project
      final res = firestore.collection('users').doc(userRef.id).update({
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
