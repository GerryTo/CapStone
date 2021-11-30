import 'package:flutter/material.dart';

enum AddFeedStatus { init, success, fail }

class AddFeedPageViewModel extends ChangeNotifier {
  var status = AddFeedStatus.init;

  void send() {}
}
