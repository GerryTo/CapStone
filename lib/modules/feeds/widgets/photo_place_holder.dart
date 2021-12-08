import 'package:flutter/material.dart';

class PhotoPlaceHolder extends StatelessWidget {
  const PhotoPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1, child: Container(color: Colors.grey));
  }
}
