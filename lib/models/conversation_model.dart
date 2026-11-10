class ConversationModel {
  final String id;
  final DateTime createdAt;

  ConversationModel({
    required this.id,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
  };
}
