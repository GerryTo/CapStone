import 'dart:developer';

import 'package:capstone/modules/auth/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum ShowDataStatus { init, loading, success, fail }

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.userRef) {
    log(userRef.toString(), name: "USER_PROFILE");
    getData();
  }

  User? user;
  final DocumentReference userRef;

  var status = ShowDataStatus.init;
  Future<void> getData() async {
    try {
      status = ShowDataStatus.loading;
      notifyListeners();
      final userSnapshot = await userRef.get();
      user = User.fromMap(userSnapshot.data() as Map<String, dynamic>);
      log(user.toString(), name: "USER_PROFILE");
      status = ShowDataStatus.success;
      notifyListeners();
    } catch (e) {
      log(e.toString(), name: "USER_PROFILE");
      status = ShowDataStatus.fail;
      notifyListeners();
    }
  }
}
