import 'dart:developer';

import 'package:capstone/constants/city_names.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileViewModel extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final currentUserInfo = ServiceLocator.getIt.get<CurrentUserInfo>();

  String? _avatarUrl;
  String? _name;
  String? _company;
  String? _location;

  EditProfileViewModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final userRef = await currentUserInfo.userRef;
      final user = await firestore.collection('users').doc(userRef?.id).get();
      final userData = user.data();

      _avatarUrl = userData?['avatar_url'];
      _name = userData?['name'];
      _company = userData?['company'];
      _location = userData?['location'];
      notifyListeners();
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    }
  }

  String get avatarUrl => _avatarUrl ?? "https://dummyimage.com/96x96/000/fff";
  String get name => _name ?? "...";
  String get company => _company ?? "...";
  String get location => _location ?? citiesData.first;

  Future<void> updateName(String newName) async {
    try {
      final userRef = await currentUserInfo.userRef;
      firestore.collection('users').doc(userRef?.id).update({"name": newName});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updateCompany(String company) async {
    try {
      final userRef = await currentUserInfo.userRef;
      firestore
          .collection('users')
          .doc(userRef?.id)
          .update({"company": company});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updateLocation(String location) async {
    try {
      final userRef = await currentUserInfo.userRef;
      firestore
          .collection('users')
          .doc(userRef?.id)
          .update({"location": location});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }
}
