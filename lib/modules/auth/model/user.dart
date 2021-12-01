import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? avatarUrl;
  String? company;
  String? email;
  String? location;
  String? name;
  String? phone;
  List<DocumentReference>? projects;

  User({
    this.avatarUrl,
    this.company,
    this.email,
    this.location,
    this.name,
    this.phone,
    this.projects,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        avatarUrl: json['avatar_url'] as String?,
        company: json['company'] as String?,
        email: json['email'] as String?,
        location: json['location'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        projects: json['projects'] as List<DocumentReference>?,
      );

  Map<String, dynamic> toMap() => {
        'avatar_url': avatarUrl,
        'company': company,
        'email': email,
        'location': location,
        'name': name,
        'phone': phone,
        'projects': projects,
      };

  User copyWith({
    String? avatarUrl,
    String? company,
    String? email,
    String? location,
    String? name,
    String? phone,
    List<String>? projects,
  }) {
    return User(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      company: company ?? this.company,
      email: email ?? this.email,
      location: location ?? this.location,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      projects: projects as List<DocumentReference>? ?? this.projects,
    );
  }
}
