import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class ConversationPreviewModel {
  final ConversationModel conversation;
  final List<UserModel> participants;
  final MessageWithUserModel? lastMessage;

  ConversationPreviewModel({
    required this.conversation,
    required this.participants,
    required this.lastMessage,
  });
}

class MessageWithUserModel {
  final MessageModel message;
  final UserModel sender;

  MessageWithUserModel({
    required this.message,
    required this.sender,
  });
}