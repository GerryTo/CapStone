class UserProfile {
  String avatarUrl;
  String company;
  String location;
  String name;
  String phone;

  UserProfile(
      {required this.avatarUrl,
      required this.name,
      required this.location,
      required this.company,
      required this.phone});

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
        avatarUrl: data['avatar_url'],
        company: data['company'],
        location: data['location'],
        name: data['name'],
        phone: data['phone'],
      );
  Map<String, dynamic> toMap() => {
        'avatar_url': avatarUrl,
        'company': company,
        'location': location,
        'name': name,
        'phone': phone
      };
}
