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
    id: json['id'].toString(),
    name: json['name'].toString(),
    username: json['username'].toString(),
    avatarUrl: json['avatar_url']?.toString(),
    createdAt: DateTime.parse(json['created_at'].toString()),
    bio: json['bio']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'avatar_url': avatarUrl,
    'created_at': createdAt.toIso8601String(),
    'bio': bio,
  };
}
