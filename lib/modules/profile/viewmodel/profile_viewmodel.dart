import 'package:capstone/modules/auth/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum ShowDataStatus { init, loading, success, fail }

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.userRef) {
    getData();
  }

  User? user;
  final DocumentReference? userRef;

  var status = ShowDataStatus.init;
  Future<void> getData() async {
    try {
      //loading
      status = ShowDataStatus.loading;
      notifyListeners();

      //mengambil data dari backend
      final userSnapshot = await userRef?.get();
      final data = userSnapshot?.data() as Map<String, dynamic>?;
      if (data == null) return;
      user = User.fromMap(data);

      //sukses
      status = ShowDataStatus.success;
      notifyListeners();
    } catch (e) {
      // gagal
      status = ShowDataStatus.fail;
      notifyListeners();
    }
  }
}
