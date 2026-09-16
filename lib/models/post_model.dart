import 'user_model.dart';

class PostModel {
  final int id;
  final int userId;
  final String caption;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.caption,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    userId: json['userId'],
    caption: json['caption'],
    createdAt: DateTime.parse(json['createdAt']),
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'caption': caption,
    'createdAt': createdAt.toIso8601String(),
  };
}
