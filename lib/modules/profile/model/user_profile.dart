class UserProfile{
  String avatar_url;
  String company;
  String location;
  String name;
  String phone;


  UserProfile({required this.avatar_url, required this.name, required this.location, required this.company, required this.phone});

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
    avatar_url: data['avatar_url'],
    company: data['company'],
    location: data['location'],
    name: data['name'],
    phone: data['phone'],
  );
  Map<String, dynamic> toMap()=>{
    'avatar_url': avatar_url,
    'company' : company,
    'location' : location,
    'name' : name,
    'phone': phone
  };
}