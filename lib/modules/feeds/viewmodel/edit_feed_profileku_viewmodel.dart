import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EditFeedProfileKuViewModel extends ChangeNotifier{
  final fireStore = FirebaseFirestore.instance;
  String ref;
  String? title;
  String? desc;

  EditFeedProfileKuViewModel({required this.ref}){
    fetchData(ref);
  }


  Future<void>fetchData(String ref)async {
    try{
      final data = await fireStore.collection('projects').doc(ref).get();
      title = data['title'];
      desc = data['description'];
      notifyListeners();
    }catch(e){
     log('error', error: e);
    }
  }

  Future<void>editFeed(String ref,String? newTitle, String? newDesc)async{
    try{
      fireStore.collection('projects').doc(ref).update({"title":newTitle,"description":newDesc});
    }catch(e){
      log('error',error: e);
    }
  }

}