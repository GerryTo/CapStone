import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum AddFeedStatus { init, success, fail }

class AddFeedPageViewModel extends ChangeNotifier {
  var status = AddFeedStatus.init;

  void send(
      {required String name,
      required String description,
      required List<XFile> files}) {}
}
