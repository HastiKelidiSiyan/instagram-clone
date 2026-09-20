import '../user_model.dart';
import '../post_model.dart';
import '../story_model.dart';

class ProfileData {
  final UserModel user;
  final List<PostModel> posts;
  final int followerCount;
  final int followingCount;
  final bool isFollowedByCurrentUser;
  final List<StoryModel> activeStories;

  ProfileData({
    required this.user,
    required this.posts,
    required this.followerCount,
    required this.followingCount,
    required this.isFollowedByCurrentUser,
    required this.activeStories,
  });
}
