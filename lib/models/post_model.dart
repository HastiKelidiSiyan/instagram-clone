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
    userId: json['user_id'].toString(),
    caption: json['caption'].toString(),
    createdAt: DateTime.parse(json['created_at'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'caption': caption,
    'created_at': createdAt.toIso8601String(),
  };
}
