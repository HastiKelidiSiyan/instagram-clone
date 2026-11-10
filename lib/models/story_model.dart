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
        id: json['id'].toString(),
        userId: json['user_id'].toString(),
        mediaUrl: json['media_url'].toString(),
        mediaType: json['media_type'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        expiresAt: DateTime.parse(json['expires_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'media_url': mediaUrl,
        'media_type': mediaType,
        'created_at': createdAt.toIso8601String(),
        'expires_at': expiresAt.toIso8601String(),
      };
}
