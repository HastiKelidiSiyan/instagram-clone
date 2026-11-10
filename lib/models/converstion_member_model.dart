class ConversationMemberModel {

  final String conversationId;
  final String userId;

  ConversationMemberModel({
    required this.conversationId,
    required this.userId,
  });

  factory ConversationMemberModel.fromJson(Map<String, dynamic> json) =>
      ConversationMemberModel(
        conversationId: json['conversation_id'].toString(),
        userId: json['user_id'].toString(),
      );

  Map<String, dynamic> toJson() => {
    'conversation_id': conversationId,
    'user_id': userId,
  };
}
