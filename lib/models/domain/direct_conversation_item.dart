import '../conversation_model.dart';
import '../user_model.dart';
import '../message_model.dart';
import 'story_item_data.dart';

class DirectConversationItem {
  final ConversationModel conversation;
  final UserModel otherParticipant;
  final MessageModel? latestMessage;
  final StoryItemData? activeStory;

  DirectConversationItem({
    required this.conversation,
    required this.otherParticipant,
    required this.latestMessage,
    required this.activeStory,
  });
}
