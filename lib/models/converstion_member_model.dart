class ConversationMemberModel {

  final String conversationId;
  final String userId;

  ConversationMemberModel({
    required this.conversationId,
    required this.userId,
  });

  factory ConversationMemberModel.fromJson(Map<String, dynamic> json) => ConversationMemberModel(
    conversationId: json['conversationId'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'conversationId': conversationId,
    'userId': userId,
  };
}