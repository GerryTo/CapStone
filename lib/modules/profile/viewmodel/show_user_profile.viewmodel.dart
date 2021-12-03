import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../service_locator.dart';

enum ShowDataStatus { init, loading, success, fail }

class ShowUserProfileViewModel extends ChangeNotifier {
  ShowUserProfileViewModel(this.currentUserInfo) {
    getData();
  }

  User? user;
  final fireStore = FirebaseFirestore.instance.collection('users');
  final CurrentUserInfo currentUserInfo;

  var status = ShowDataStatus.init;
  Future<void> getData() async {
    try {
      status = ShowDataStatus.loading;
      notifyListeners();
      user = await currentUserInfo.userData;
      notifyListeners();
      status = ShowDataStatus.success;
      notifyListeners();
    } catch (e) {
      status = ShowDataStatus.fail;
      notifyListeners();
    }
  }
}
