import 'dart:developer';

import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  final CurrentUserInfo currentUserInfo;
  User? user;

  SettingsViewModel(this.currentUserInfo) {
    getUserData();
  }

  void getUserData() async {
    try {
      user = await currentUserInfo.userData;
      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
