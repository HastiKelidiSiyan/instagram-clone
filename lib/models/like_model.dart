class LikeModel{

  final int id;
  final int userId;
  final int postId;
  final DateTime createdAt;

  LikeModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        id: json['id'],
        userId: json['userId'],
        postId: json['postId'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'postId': postId,
        'createdAt': createdAt.toIso8601String(),
      };
}