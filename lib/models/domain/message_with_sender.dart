import '../message_model.dart';
import '../user_model.dart';

class MessageWithSender {
  final MessageModel message;
  final UserModel sender;

  const MessageWithSender({
    required this.message,
    required this.sender,
  });

  factory MessageWithSender.fromJson(Map<String, dynamic> json) {
    return MessageWithSender(
      message: MessageModel.fromJson(json),
      sender: UserModel.fromJson(
        Map<String, dynamic>.from(json['sender']),
      ),
    );
  }
}
