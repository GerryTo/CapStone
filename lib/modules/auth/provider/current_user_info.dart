import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/modules/auth/model/user.dart' as app;
import 'package:flutter/material.dart';

class CurrentUserInfo extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  app.User? _userData;

  String? get email {
    return _auth.currentUser?.email;
  }

  String? get id {
    return _auth.currentUser?.uid;
  }

  Future<app.User?> get userData async {
    if (_userData != null) {
      return _userData;
    } else {
      await getUserData();
      return _userData;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserSnapshot() async {
    final snap =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();

    return snap;
  }

  Future<void> getUserData() async {
    final snap = await _getUserSnapshot();
    final data = snap.data();
    if (data != null) {
      _userData = app.User.fromMap(data);
      notifyListeners();
    }
  }

  DocumentReference? get userRef =>
      _firestore.collection("users").doc(_auth.currentUser?.uid);
}
