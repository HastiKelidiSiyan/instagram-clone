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
    userId: json['userId'] ?? json['user_id'],
    postId: json['postId'] ?? json['post_id'],
    text: json['text'] ?? json['textContent'] ?? json['text_content'] ?? '',
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : (json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'postId': postId,
    'textContent': text,
    'createdAt': createdAt.toIso8601String(),
  };
}
