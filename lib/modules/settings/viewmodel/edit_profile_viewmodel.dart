import 'dart:developer';
import 'dart:io';

import 'package:capstone/constants/city_names.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditProfileViewModel extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final CurrentUserInfo currentUserInfo;
  final storage = FirebaseStorage.instance;

  String? _avatarUrl;
  String? _name;
  String? _company;
  String? _location;
  String? _phone;

  bool _disposed = false;

  EditProfileViewModel(this.currentUserInfo) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final user =
          await firestore.collection('users').doc(currentUserInfo.id).get();
      final userData = user.data();

      _avatarUrl = userData?['avatar_url'];
      _name = userData?['name'];
      _company = userData?['company'];
      _location = userData?['location'];
      _phone = userData?['phone'];
      notifyListeners();
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    }
  }

  String? get avatarUrl => _avatarUrl;
  String get name => _name ?? "...";
  String get company => _company ?? "...";
  String get location => _location ?? citiesData.first;
  String get phone => _phone ?? '...';

  Future<void> updateName(String newName) async {
    try {
      firestore
          .collection('users')
          .doc(currentUserInfo.id)
          .update({"name": newName});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updateCompany(String company) async {
    try {
      firestore
          .collection('users')
          .doc(currentUserInfo.id)
          .update({"company": company});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updateLocation(String location) async {
    try {
      firestore
          .collection('users')
          .doc(currentUserInfo.id)
          .update({"location": location});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updateAvatar(File imageFile) async {
    try {
      final avatar = await storage
          .ref('avatar/${currentUserInfo.email}')
          .putFile(imageFile);
      final avatarUrl = await avatar.ref.getDownloadURL();
      firestore
          .collection('users')
          .doc(currentUserInfo.id)
          .update({"avatar_url": avatarUrl});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  Future<void> updatePhone(String phone) async {
    try {
      firestore
          .collection('users')
          .doc(currentUserInfo.id)
          .update({"phone": phone});
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    } finally {
      fetchData();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
