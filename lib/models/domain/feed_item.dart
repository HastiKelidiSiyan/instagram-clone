import '../post_model.dart';
import '../user_model.dart';
import '../post_media_model.dart';

class FeedItem {
  final PostModel post;
  final UserModel author;
  final List<PostMediaModel> media;
  final int likeCount;
  final UserModel? latestLiker;
  final int commentCount;
  final bool isLikedByCurrentUser;

  FeedItem({
    required this.post,
    required this.author,
    required this.media,
    required this.likeCount,
    required this.latestLiker,
    required this.commentCount,
    required this.isLikedByCurrentUser,
  });
}
