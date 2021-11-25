import 'package:capstone/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Column(children: [
              Image.network('https://dummyimage.com/350x150/000/fff')
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network('https://dummyimage.com/30x30/000/fff'),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text('Nama A'),
                            Text('12 pojek'),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () =>
                        Routes.router.navigateTo(context, Routes.profileUser),
                    icon: Icon(Icons.arrow_right),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
