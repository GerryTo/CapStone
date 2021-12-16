import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  DocumentReference? ref;
  String? description;
  List<String>? images;
  String? title;
  int? price;
  DocumentReference? userReference;
  Timestamp? timestamp;
  int? landArea;
  String? location;

  Feed({
    this.ref,
    this.description,
    this.images,
    this.title,
    this.userReference,
    this.timestamp,
    this.price,
    this.landArea,
    this.location,
  });

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
      ref: data['ref'] as DocumentReference?,
      description: data['description'] as String?,
      images: (data['images'] as List?)?.map((e) => e.toString()).toList(),
      title: data['title'] as String?,
      userReference: data['userReference'] as DocumentReference?,
      timestamp: data['timestamp'] as Timestamp?,
      price: data['price'] as int?,
      landArea: data['landArea'] as int?,
      location: data['location'] as String?);

  Map<String, dynamic> toMap() => {
        'description': description,
        'images': images,
        'title': title,
        'userReference': userReference,
        'timestamp': timestamp,
        'price': price,
        'landArea': landArea,
        'location' : location,
      };

  Feed copyWith({
    DocumentReference? ref,
    String? description,
    List<String>? images,
    String? title,
    DocumentReference? userReference,
    Timestamp? timestamp,
    int? price,
    int? landArea,
    String? location,
  }) {
    return Feed(
      ref: ref ?? this.ref,
      description: description ?? this.description,
      images: images ?? this.images,
      title: title ?? this.title,
      userReference: userReference ?? this.userReference,
      timestamp: timestamp ?? this.timestamp,
      price: price ?? this.price,
      landArea: landArea ?? this.landArea,
      location: location ?? this.location,
    );
  }
}
