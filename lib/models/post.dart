import 'user.dart';

class Post {
  final User user;
  final String subtitle;
  final String postImage;
  final String caption;
  final User? likedBy;
  final int totalLikes;
  final int totalComments;

  Post({
    required this.user,
    required this.subtitle,
    required this.postImage,
    required this.caption,
    required this.likedBy,
    this.totalLikes = 0,
    this.totalComments = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    user: User.fromJson(json['user']),
    subtitle: json['subtitle'],
    postImage: json['postImage'],
    caption: json['caption'],
    likedBy: json['likedBy'] != null ? User.fromJson(json['likedBy']) : null,
    totalLikes: json['totalLikes'] ?? 0,
    totalComments: json['totalComments'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'subtitle': subtitle,
    'postImage': postImage,
    'caption': caption,
    'likedBy': likedBy?.toJson(),
    'totalLikes': totalLikes,
    'totalComments': totalComments,
  };
}
