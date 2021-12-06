import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  String? description;
  List<String>? images;
  String? title;
  DocumentReference? userReference;
  Timestamp? timestamp;

  Feed(
      {this.description,
      this.images,
      this.title,
      this.userReference,
      this.timestamp});

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
        description: data['description'] as String?,
        images: (data['images'] as List).map((e) => e.toString()).toList(),
        title: data['title'] as String?,
        userReference: data['userReference'] as DocumentReference?,
        timestamp: data['timestamp'] as Timestamp?,
      );

  Map<String, dynamic> toMap() => {
        'description': description,
        'images': images,
        'title': title,
        'userReference': userReference,
        'timestamp': timestamp,
      };
}
