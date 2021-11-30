import 'dart:convert';

class Feed {
  String? description;
  List<String>? images;
  String? title;

  Feed({this.description, this.images, this.title});

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
        description: data['description'] as String?,
        images: data['images'] as List<String>?,
        title: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'description': description,
        'images': images,
        'name': title,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Feed].
  factory Feed.fromJson(String data) {
    return Feed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Feed] to a JSON string.
  String toJson() => json.encode(toMap());

  Feed copyWith({
    String? description,
    List<String>? images,
    String? name,
  }) {
    return Feed(
      description: description ?? this.description,
      images: images ?? this.images,
      title: name ?? this.title,
    );
  }
}
