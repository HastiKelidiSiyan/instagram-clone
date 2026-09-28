import 'package:instagram_clone/models/domain/home_post.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class ProfileModel {
  final UserModel user;
  final List<StoryModel> stories;
  final List<HomePostModel> posts;

  ProfileModel({
    required this.user,
    required this.stories,
    required this.posts,
  });
}