class CommentsModel {
  final int id;
  final int postId;
  final int userId;
  final String text;
  final DateTime createdAt;

  CommentsModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.createdAt,
  });
}