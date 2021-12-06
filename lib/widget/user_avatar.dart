import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
