import '../conversation_model.dart';
import '../user_model.dart';
import '../message_model.dart';
import 'story_item_data.dart';

class DirectConversationItem {
  final ConversationModel conversation;
  final UserModel otherParticipant;
  final MessageModel? latestMessage;
  final StoryItemData? activeStory;

  const DirectConversationItem({
    required this.conversation,
    required this.otherParticipant,
    required this.latestMessage,
    required this.activeStory,
  });

  factory DirectConversationItem.fromJson(
    Map<String, dynamic> json, {
    required String currentUserId,
  }) {
    final conversationJson = Map<String, dynamic>.from(
      json['conversation'],
    );

    final membersJson = conversationJson['members'] as List<dynamic>? ?? [];

    final messagesJson = conversationJson['messages'] as List<dynamic>? ?? [];

    Map<String, dynamic>? otherMemberJson;

    for (final item in membersJson) {
      final memberJson = Map<String, dynamic>.from(item);

      if (memberJson['user_id'].toString() != currentUserId) {
        otherMemberJson = memberJson;
        break;
      }
    }

    if (otherMemberJson == null) {
      throw const FormatException(
        'The conversation does not have another participant.',
      );
    }

    final profileJson = Map<String, dynamic>.from(
      otherMemberJson['profile'],
    );

    final latestMessage = messagesJson.isEmpty
        ? null
        : MessageModel.fromJson(
            Map<String, dynamic>.from(messagesJson.first),
          );

    return DirectConversationItem(
      conversation: ConversationModel.fromJson(conversationJson),
      otherParticipant: UserModel.fromJson(profileJson),
      latestMessage: latestMessage,
      activeStory: null,
    );
  }
}
