import 'package:flutter/cupertino.dart';

class CardPhoto extends StatelessWidget {
  CardPhoto(this.photoUrl, {Key? key}) : super(key: key);
  String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                photoUrl ?? 'https://dummyimage.com/500x300/000/fff'),
            fit: BoxFit.fill),
      ),
    );
  }
}
