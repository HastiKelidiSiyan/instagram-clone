import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/follow_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/domain/home_post.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class PostRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<HomePostModel>> getHomePosts(String currentUserId) async {
    if (await connectivityResult.isConnected()) {
      final posts = await remoteDataSource.getHomePosts(currentUserId);
      for (final item in posts) {
        await localDataSource.cacheUser(item.author);
        await localDataSource.cachePost(item.post);
        for (final media in item.media) {
          await localDataSource.cachePostMedia(media);
        }
        for (final like in item.likes) {
          await localDataSource.cacheUser(like.user);
          await localDataSource.cacheLike(like.like);
        }
        for (final comment in item.comments) {
          await localDataSource.cacheUser(comment.user);
          await localDataSource.cacheComment(comment.comment);
        }
      }
      return posts;
    }

    return localDataSource.getHomePosts(currentUserId);
  }

  Future<PostModel> getPost(String postId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getPost(postId);
    }

    return localDataSource.getPost(postId);
  }

  Future<List<PostModel>> getUserPosts(String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getUserPosts(userId);
    }

    return localDataSource.getUserPosts(userId);
  }

  Future<PostModel> createPost(PostModel post) async {
    if (await connectivityResult.isConnected()) {
      final createdPost = await remoteDataSource.createPost(post);
      await localDataSource.createPost(createdPost);
      return createdPost;
    }

    await localDataSource.createPost(post);
    return post;
  }

  Future<void> deletePost(String postId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.deletePost(postId);
    }

    await localDataSource.deletePost(postId);
  }

  Future<List<PostMediaModel>> getPostMedia(String postId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getPostMedia(postId);
    }

    return localDataSource.getPostMedia(postId);
  }

  Future<PostMediaModel> createPostMedia(PostMediaModel media) async {
    if (await connectivityResult.isConnected()) {
      final createdMedia = await remoteDataSource.createPostMedia(media);
      await localDataSource.createPostMedia(createdMedia);
      return createdMedia;
    }

    await localDataSource.createPostMedia(media);
    return media;
  }

  Future<void> deletePostMedia(String mediaId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.deletePostMedia(mediaId);
    }

    await localDataSource.deletePostMedia(mediaId);
  }

  Future<List<CommentModel>> getComments(String postId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getComments(postId);
    }

    return localDataSource.getComments(postId);
  }

  Future<CommentModel> createComment(CommentModel comment) async {
    if (await connectivityResult.isConnected()) {
      final createdComment = await remoteDataSource.createComment(comment);
      await localDataSource.createComment(createdComment);
      return createdComment;
    }

    await localDataSource.createComment(comment);
    return comment;
  }

  Future<void> deleteComment(String commentId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.deleteComment(commentId);
    }

    await localDataSource.deleteComment(commentId);
  }

  Future<bool> isPostLiked(String userId, String postId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.isPostLiked(userId, postId);
    }

    return localDataSource.isPostLiked(userId, postId);
  }

  Future<LikeModel> likePost(LikeModel like) async {
    if (await connectivityResult.isConnected()) {
      final createdLike = await remoteDataSource.likePost(like);
      await localDataSource.likePost(createdLike);
      return createdLike;
    }

    await localDataSource.likePost(like);
    return like;
  }

  Future<void> unlikePost(String userId, String postId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.unlikePost(userId, postId);
    }

    await localDataSource.unlikePost(userId, postId);
  }

  Future<List<FollowModel>> getFollowers(String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getFollowers(userId);
    }

    return localDataSource.getFollowers(userId);
  }

  Future<List<FollowModel>> getFollowing(String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getFollowing(userId);
    }

    return localDataSource.getFollowing(userId);
  }

  Future<FollowModel> followUser(FollowModel follow) async {
    if (await connectivityResult.isConnected()) {
      final createdFollow = await remoteDataSource.followUser(follow);
      await localDataSource.followUser(createdFollow);
      return createdFollow;
    }

    await localDataSource.followUser(follow);
    return follow;
  }

  Future<void> unfollowUser(String followerId, String followingId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.unfollowUser(followerId, followingId);
    }

    await localDataSource.unfollowUser(followerId, followingId);
  }
}
