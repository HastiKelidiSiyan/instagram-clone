import '../user_model.dart';
import '../story_model.dart';
import 'post_with_media.dart';

class ProfileData {
  final UserModel user;
  final List<PostWithMedia> posts;
  final int followerCount;
  final int followingCount;
  final bool isFollowedByCurrentUser;
  final List<StoryModel> activeStories;

  const ProfileData({
    required this.user,
    required this.posts,
    required this.followerCount,
    required this.followingCount,
    required this.isFollowedByCurrentUser,
    required this.activeStories,
  });

  factory ProfileData.fromJson(
    Map<String, dynamic> json, {
    required String currentUserId,
  }) {
    final postsJson = json['posts'] as List<dynamic>? ?? [];
    final followersJson = json['followers'] as List<dynamic>? ?? [];
    final followingJson = json['following'] as List<dynamic>? ?? [];
    final activeStoriesJson =
        json['active_stories'] as List<dynamic>? ?? [];

    return ProfileData(
      user: UserModel.fromJson(json),
      posts: postsJson
          .map(
            (item) => PostWithMedia.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
      followerCount: followersJson.length,
      followingCount: followingJson.length,
      isFollowedByCurrentUser: followersJson.any((item) {
        final follower = Map<String, dynamic>.from(item);
        return follower['follower_id'].toString() == currentUserId;
      }),
      activeStories: activeStoriesJson
          .map(
            (item) => StoryModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }
}
