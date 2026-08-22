import 'user_model.dart';

class MessageModel {
  final UserModel user;
  final String lastMessage;
  final DateTime date;

  MessageModel({required this.user, required this.lastMessage, required this.date});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    user: UserModel.fromJson(json['user']),
    lastMessage: json['lastMessage'],
    date: DateTime.parse(json['date']),
  );

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'lastMessage': lastMessage,
    'date': date.toIso8601String(),
  };
}
