import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


enum EditFeedStatus { init, loading, success, fail }

class EditFeedProfileKuViewModel extends ChangeNotifier{
  final fireStore = FirebaseFirestore.instance;
  String ref;
  String? title;
  String? desc;
  var status = EditFeedStatus.init;

  EditFeedProfileKuViewModel({required this.ref}){
    fetchData(ref);
  }

  Future<void>fetchData(String ref)async {
    try{
      status = EditFeedStatus.loading;
      notifyListeners();
      final data = await fireStore.collection('projects').doc(ref).get();
      title = data['title'];
      desc = data['description'];
      status = EditFeedStatus.success;
      notifyListeners();
    }catch(e,s){
     log('FETCH_DATA', error: e, stackTrace: s);
     status = EditFeedStatus.fail;
     notifyListeners();
    }
  }

  Future<void>deleteFeed(String ref) async{
    try{
      status = EditFeedStatus.loading;
      notifyListeners();
      fireStore.collection('projects').doc(ref).delete();
      status = EditFeedStatus.success;
      notifyListeners();
    }catch (e, s) {
      log('DELETE_FEED', error: e, stackTrace: s);
      status = EditFeedStatus.fail;
      notifyListeners();
    }
  }

  Future<void>editFeed(String ref,String? newTitle, String? newDesc)async{
    try{
      fireStore.collection('projects').doc(ref).update({"title":newTitle,"description":newDesc});
    }catch (e, s) {
      log('EDIT_FEED', error: e, stackTrace: s);
      status = EditFeedStatus.fail;
      notifyListeners();
    }
  }

}