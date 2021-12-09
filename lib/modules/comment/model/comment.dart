import 'package:cloud_firestore/cloud_firestore.dart';

class UserComment {
  final DocumentReference? user;
  final String? body;
  final Timestamp? timestamp;

  UserComment({this.user, this.body, this.timestamp});

  Map<String, dynamic> toMap() => {
        'user': user,
        'body': body,
        'timestamp': timestamp,
      };

  static UserComment fromMap(Map<String, dynamic> map) {
    return UserComment(
      user: map['user'],
      body: map['body'],
      timestamp: map['timestamp'],
    );
  }
}
