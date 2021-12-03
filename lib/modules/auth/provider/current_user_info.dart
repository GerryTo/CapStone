import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/modules/auth/model/user.dart' as app;
import 'package:flutter/material.dart';

class CurrentUserInfo extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  DocumentReference? _userRef;
  app.User? _userData;

  String? get email {
    return _auth.currentUser?.email;
  }

  Future<app.User?> get userData async {
    if (_userData != null) {
      return _userData;
    } else {
      await getUserData();
      return _userData;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getUserSnapshot() async {
    final snap = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return snap;
  }

  Future<void> getUserData() async {
    final snap = await _getUserSnapshot();
    final data = snap.docs.first.data();
    _userData = app.User.fromMap(data);
    notifyListeners();
  }

  Future<DocumentReference?> _getUserRef() async {
    try {
      final snap = await _getUserSnapshot();
      return snap.docs.first.reference;
    } on Exception catch (e, s) {
      log("current_user_info", error: e, stackTrace: s);
    }
  }

  Future<DocumentReference<Object?>?> get userRef async {
    if (_userRef != null) {
      return _userRef;
    } else {
      _userRef = await _getUserRef();
      return _userRef;
    }
  }
}
