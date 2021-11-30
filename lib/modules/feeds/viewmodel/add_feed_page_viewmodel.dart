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

  String _getUserName() {
    return auth.currentUser?.email ?? '';
  }

  Future<List<String>> uploadImages(List<XFile> files) {
    return Future.wait(files.map((file) async {
      final task = await storage
          .ref('gambar-feed/${_getUserName()}-${file.name}')
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

      firestore
          .collection('projects')
          .add(Feed(title: title, description: description, images: imageURLs)
              .toMap())
          .whenComplete(() {
        status = AddFeedStatus.success;
        notifyListeners();
      });
    } catch (e) {
      log('Error: ' + e.toString());
      status = AddFeedStatus.fail;
      notifyListeners();
    }
  }
}
