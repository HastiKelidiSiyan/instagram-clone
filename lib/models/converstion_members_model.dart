class ConverstionMembersModel {

  final int conversationId;
  final int userId;

  ConverstionMembersModel({
    required this.conversationId,
    required this.userId,
  });

  factory ConverstionMembersModel.fromJson(Map<String, dynamic> json) => ConverstionMembersModel(
    conversationId: json['conversationId'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'conversationId': conversationId,
    'userId': userId,
  };
}