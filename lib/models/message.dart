import 'user.dart';

class Message {
  final User user;
  final String lastMessage;
  final DateTime date;

  Message({required this.user, required this.lastMessage, required this.date});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    user: User.fromJson(json['user']),
    lastMessage: json['lastMessage'],
    date: DateTime.parse(json['date']),
  );

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'lastMessage': lastMessage,
    'date': date.toIso8601String(),
  };
}
