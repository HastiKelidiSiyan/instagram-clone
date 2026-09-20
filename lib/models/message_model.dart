class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'].toString(),
    conversationId: json['conversationId'] ?? json['conversation_id'],
    senderId: json['senderId'] ?? json['sender_id'],
    text: json['text'] ?? json['textContent'] ?? json['text_content'] ?? '',
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : (json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'textContent': text,
    'createdAt': createdAt.toIso8601String(),
  };
}
