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
    conversationId: json['conversation_id'].toString(),
    senderId: json['sender_id'].toString(),
    text: json['text'].toString(),
    createdAt: DateTime.parse(json['created_at'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversation_id': conversationId,
    'sender_id': senderId,
    'text': text,
    'created_at': createdAt.toIso8601String(),
  };
}
