class User {
  final int userId;
  final String name;
  final String username;
  final String avatar;
  final int totalPosts;
  final int totalFollowers;
  final int totalFollowings;
  final String bio;

  User({
    required this.userId,
    required this.name,
    required this.username,
    required this.avatar,
    this.totalPosts = 0,
    this.totalFollowers = 0,
    this.totalFollowings = 0,
    required this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['userId'],
    name: json['name'],
    username: json['username'],
    avatar: json['avatar'],
    totalPosts: json['totalPosts'],
    totalFollowers: json['totalFollowers'],
    totalFollowings: json['totalFollowings'],
    bio: json['bio'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'username': username,
    'avatar': avatar,
    'totalPosts': totalPosts,
    'totalFollowers': totalFollowers,
    'totalFollowings': totalFollowings,
    'bio': bio,
  };
}
