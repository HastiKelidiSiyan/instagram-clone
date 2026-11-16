import '../post_model.dart';
import '../user_model.dart';
import '../post_media_model.dart';

class PostItem {
  final PostModel post;
  final UserModel author;
  final List<PostMediaModel> media;
  final int likeCount;
  final UserModel? latestLiker;
  final int commentCount;
  final bool isLikedByCurrentUser;

  const PostItem({
    required this.post,
    required this.author,
    required this.media,
    required this.likeCount,
    required this.latestLiker,
    required this.commentCount,
    required this.isLikedByCurrentUser,
  });

  factory PostItem.fromJson(
  Map<String, dynamic> json, {
  required String currentUserId,
}) {
  final mediaJson = json['media'] as List<dynamic>? ?? [];
  final likesJson = json['likes'] as List<dynamic>? ?? [];
  final commentsJson = json['comments'] as List<dynamic>? ?? [];

  UserModel? latestLiker;

  if (likesJson.isNotEmpty) {
    final latestLike = Map<String, dynamic>.from(likesJson.first);
    final likerJson = latestLike['liker'];

    if (likerJson != null) {
      latestLiker = UserModel.fromJson(
        Map<String, dynamic>.from(likerJson),
      );
    }
  }

  return PostItem(
    post: PostModel.fromJson(json),
    author: UserModel.fromJson(
      Map<String, dynamic>.from(json['author']),
    ),
    media: mediaJson
        .map(
          (item) => PostMediaModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList(),
    likeCount: likesJson.length,
    latestLiker: latestLiker,
    commentCount: commentsJson.length,
    isLikedByCurrentUser: likesJson.any(
      (item) {
        final like = Map<String, dynamic>.from(item);
        return like['user_id'].toString() == currentUserId;
      },
    ),
  );
}
}
