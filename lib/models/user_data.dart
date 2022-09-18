class UserData {
  final String id;
  final String name;
  final String username;
  final String biography;
  final String profilePictureUrl;

  UserData({
    required this.id,
    required this.name,
    required this.username,
    required this.biography,
    required this.profilePictureUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      biography: json['biography'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'biography': biography,
      'profile_picture_url': profilePictureUrl,
    };
  }
}
