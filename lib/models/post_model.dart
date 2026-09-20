import 'user_model.dart';

class PostModel {
  final String id;
  final String userId;
  final String caption;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.caption,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'].toString(),
    userId: json['userId'] ?? json['user_id'],
    caption: json['caption'] ?? json['text'] ?? '',
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : (json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'caption': caption,
    'createdAt': createdAt.toIso8601String(),
  };
}
