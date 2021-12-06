import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFeed extends StatelessWidget {
  const CardFeed(this.feed, {Key? key}) : super(key: key);
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    final userRef = feed.userReference;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Column(children: [
              Image.network(feed.images?.first ??
                  "https://via.placeholder.com/480x360?text=No+Picture")
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UserAvatar(userRef),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(feed.title ?? ""),
                            Text(feed.description ?? ""),
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

class UserAvatar extends StatelessWidget {
  const UserAvatar(
    this.userRef, {
    Key? key,
  }) : super(key: key);

  final DocumentReference? userRef;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: userRef?.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _error();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return noData();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return CircleAvatar(
              foregroundImage: NetworkImage(data["avatar_url"]));
        }
        return noData();
      },
    );
  }

  CircleAvatar _error() {
    return const CircleAvatar(
      foregroundImage:
          NetworkImage('https://via.placeholder.com/64x64?text=Error'),
    );
  }

  CircleAvatar noData() {
    return const CircleAvatar(
      foregroundImage:
          NetworkImage('https://via.placeholder.com/64x64?text=No+Data'),
    );
  }
}
