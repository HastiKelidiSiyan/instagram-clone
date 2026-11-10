class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'].toString(),
    userId: json['user_id'].toString(),
    postId: json['post_id'].toString(),
    text: json['text'].toString(),
    createdAt: DateTime.parse(json['created_at'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'post_id': postId,
    'text': text,
    'created_at': createdAt.toIso8601String(),
  };
}
