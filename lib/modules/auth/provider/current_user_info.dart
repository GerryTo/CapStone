import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserInfo {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  DocumentReference? _userRef;

  String? get email {
    return _auth.currentUser?.email;
  }

  Future<DocumentReference?> _getUserRef() async {
    try {
      final snap = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
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
