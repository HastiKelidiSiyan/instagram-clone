import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class HomePostModel {
  final PostModel post;
  final UserModel author;
  final List<PostMediaModel> media;
  final List<LikeWithUserModel> likes;
  final List<CommentWithUserModel> comments;

    HomePostModel({
    required this.post,
    required this.author,
    required this.media,
    required this.likes,
    required this.comments,
  });
}

class LikeWithUserModel {
  final LikeModel like;
  final UserModel user;

  LikeWithUserModel({
    required this.like,
    required this.user,
  });
}

class CommentWithUserModel {
  final CommentModel comment;
  final UserModel user;

  CommentWithUserModel({
    required this.comment,
    required this.user,
  });
}
