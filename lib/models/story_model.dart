import 'user_model.dart';

class StoryModel {
  final String id;
  final String userId; 
  final String mediaUrl;
  final String mediaType;
  final DateTime createdAt;
  final DateTime expiresAt;

  StoryModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.expiresAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json['id'],
        userId: json['userId'],
        mediaUrl: json['mediaUrl'],
        mediaType: json['mediaType'],
        createdAt: DateTime.parse(json['createdAt']),
        expiresAt: DateTime.parse(json['expiresAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt.toIso8601String(),
      };
}
