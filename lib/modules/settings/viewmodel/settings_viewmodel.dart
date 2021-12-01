import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/service_locator.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  final currentUserInfo = ServiceLocator.getIt.get<CurrentUserInfo>();
  User? user;

  SettingsViewModel() {
    getUserData();
  }

  void getUserData() async {
    user = await currentUserInfo.userData;
    notifyListeners();
  }
}
