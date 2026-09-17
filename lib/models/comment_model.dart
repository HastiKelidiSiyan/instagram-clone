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

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json['id'],
        userId: json['userId'],
        postId: json['postId'],
        text: json['text'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'postId': postId,
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      };
}