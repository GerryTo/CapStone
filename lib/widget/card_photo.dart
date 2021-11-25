import 'package:flutter/cupertino.dart';

class CardPhoto extends StatelessWidget {

  const CardPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://dummyimage.com/400x200/000/fff'),
            fit: BoxFit.cover),
      ),
    );
  }
}