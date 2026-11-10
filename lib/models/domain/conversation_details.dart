import '../conversation_model.dart';
import '../user_model.dart';

class ConversationDetails {
  final ConversationModel conversation;
  final List<UserModel> members;

  const ConversationDetails({
    required this.conversation,
    required this.members,
  });

  factory ConversationDetails.fromJson(Map<String, dynamic> json) {
    final membersJson = json['members'] as List<dynamic>? ?? [];

    return ConversationDetails(
      conversation: ConversationModel.fromJson(json),
      members: membersJson
          .map(
            (item) => UserModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }
}
