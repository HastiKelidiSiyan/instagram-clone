import '../story_model.dart';
import '../user_model.dart';

class StoryItemData {
  final StoryModel story;
  final UserModel author;
  final bool isViewedByCurrentUser;

  StoryItemData({
    required this.story,
    required this.author,
    required this.isViewedByCurrentUser,
  });
}
