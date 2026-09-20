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
    name: json['name'] ?? json['full_name'] ?? '',
    username: json['username'] ?? json['user_name'] ?? '',
    avatarUrl: json['avatarUrl'] ?? json['avatar_url'] ?? json['avatar'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : (json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now()),
    bio: json['bio'] ?? json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'avatarUrl': avatarUrl,
    'createdAt': createdAt.toIso8601String(),
    'bio': bio,
  };
}
