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
}