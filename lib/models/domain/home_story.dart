import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class StoryGroupModel {
  final UserModel user;
  final List<StoryModel> stories;

  StoryGroupModel({
    required this.user,
    required this.stories,
  });
}