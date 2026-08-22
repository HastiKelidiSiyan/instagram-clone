import 'user_model.dart';

class PostModel {
  final UserModel user;
  final String subtitle;
  final String postImage;
  final String caption;
  final UserModel? likedBy;
  final int totalLikes;
  final int totalComments;

  PostModel({
    required this.user,
    required this.subtitle,
    required this.postImage,
    required this.caption,
    required this.likedBy,
    this.totalLikes = 0,
    this.totalComments = 0,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    user: UserModel.fromJson(json['user']),
    subtitle: json['subtitle'],
    postImage: json['postImage'],
    caption: json['caption'],
    likedBy: json['likedBy'] != null ? UserModel.fromJson(json['likedBy']) : null,
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
