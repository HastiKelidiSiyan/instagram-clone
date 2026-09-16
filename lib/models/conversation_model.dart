class ConversationModel {

  final int id;
  final DateTime createdAt;

  ConversationModel({
    required this.id,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
  };
}
