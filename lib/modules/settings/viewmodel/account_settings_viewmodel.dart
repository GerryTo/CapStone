import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettingsViewModel extends ChangeNotifier {
  String? userEmail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AccountSettingsViewModel() {
    getUserEmail();
  }

  void getUserEmail() {
    userEmail = _auth.currentUser?.email;
    notifyListeners();
  }

  Future<void> updateEmail(String email) async {
    await _auth.currentUser?.updateEmail(email);
    getUserEmail();
  }

  Future<void> updatePassword(String pass) async {
    await _auth.currentUser?.updatePassword(pass);
  }
}
