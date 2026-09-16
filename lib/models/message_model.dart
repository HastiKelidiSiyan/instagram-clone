class MessageModel {

final int id;
final int conversationId;
final int senderId;
final String text;
final DateTime createdAt;

  MessageModel({required this.id, required this.conversationId, required this.senderId, required this.text, required this.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'],
    conversationId: json['conversationId'],
    senderId: json['senderId'],
    text: json['text'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'text': text,
    'createdAt': createdAt.toIso8601String(),
  };
}
