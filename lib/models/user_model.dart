class UserModel {
  final String id;
  final String username;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    avatarUrl: json['avatar'],
    createdAt: DateTime.parse(json['createdAt']),
    bio: json['bio'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'avatar': avatarUrl,
    'createdAt': createdAt.toIso8601String(),
    'bio': bio,
  };
}
