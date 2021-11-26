import 'package:flutter/cupertino.dart';

class CardPhoto extends StatelessWidget {

  const CardPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height ,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://dummyimage.com/500x300/000/fff'),
            fit: BoxFit.fill),
      ),
    );
  }
}