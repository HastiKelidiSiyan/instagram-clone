class UserModel {
  final int id;
  final String username;
  final String name;
  final String? avatar;
  final String? bio;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.bio,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    avatar: json['avatar'],
    createdAt: DateTime.parse(json['createdAt']),
    bio: json['bio'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'avatar': avatar,
    'createdAt': createdAt.toIso8601String(),
    'bio': bio,
  };
}
