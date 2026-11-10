class LikeModel {
  final String id;
  final String userId;
  final String postId;
  final DateTime createdAt;

  LikeModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        id: json['id'].toString(),
        userId: json['user_id'].toString(),
        postId: json['post_id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'post_id': postId,
        'created_at': createdAt.toIso8601String(),
      };
}
