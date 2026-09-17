import 'package:dio/dio.dart';
import 'package:instagram_clone/core/network/dio_client.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/follow_model.dart';

class RemoteDataSource {
  final Dio _dio;

  RemoteDataSource([Dio? dio]) : _dio = dio ?? DioClient.dio;

  Future<UserModel> getUser(String userId) async {
    final response = await _dio.get(
      '/rest/v1/users',
      queryParameters: {
        'id': 'eq.$userId',
        'select': '*',
      },
    );

    return UserModel.fromJson(response.data[0]);
  }

  Future<List<UserModel>> searchUsers(String username) async {
    final response = await _dio.get(
      '/rest/v1/users',
      queryParameters: {
        'username': 'ilike.*$username*',
        'select': '*',
      },
    );

    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<List<PostModel>> getPosts() async {
    final response = await _dio.get(
      '/rest/v1/posts',
      queryParameters: {
        'select': '*',
        'order': 'created_at.desc',
      },
    );

    return (response.data as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  Future<PostModel> getPost(String postId) async {
    final response = await _dio.get(
      '/rest/v1/posts',
      queryParameters: {
        'id': 'eq.$postId',
        'select': '*',
      },
    );

    return PostModel.fromJson(response.data[0]);
  }

  Future<List<PostModel>> getUserPosts(String userId) async {
    final response = await _dio.get(
      '/rest/v1/posts',
      queryParameters: {
        'user_id': 'eq.$userId',
        'select': '*',
        'order': 'created_at.desc',
      },
    );

    return (response.data as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  Future<PostModel> createPost(PostModel post) async {
    final response = await _dio.post(
      '/rest/v1/posts',
      data: post.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return PostModel.fromJson(response.data[0]);
  }

  Future<void> deletePost(String postId) async {
    await _dio.delete(
      '/rest/v1/posts',
      queryParameters: {
        'id': 'eq.$postId',
      },
    );
  }

  // =========================
  // POST MEDIA
  // =========================

  Future<List<PostMediaModel>> getPostMedia(String postId) async {
    final response = await _dio.get(
      '/rest/v1/post_media',
      queryParameters: {
        'post_id': 'eq.$postId',
        'select': '*',
        'order': 'position.asc',
      },
    );

    return (response.data as List)
        .map((json) => PostMediaModel.fromJson(json))
        .toList();
  }

  Future<PostMediaModel> createPostMedia(PostMediaModel media) async {
    final response = await _dio.post(
      '/rest/v1/post_media',
      data: media.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return PostMediaModel.fromJson(response.data[0]);
  }

  Future<void> deletePostMedia(String mediaId) async {
    await _dio.delete(
      '/rest/v1/post_media',
      queryParameters: {
        'id': 'eq.$mediaId',
      },
    );
  }

  // =========================
  // COMMENTS
  // =========================

  Future<List<CommentModel>> getComments(String postId) async {
    final response = await _dio.get(
      '/rest/v1/comments',
      queryParameters: {
        'post_id': 'eq.$postId',
        'select': '*',
        'order': 'created_at.asc',
      },
    );

    return (response.data as List)
        .map((json) => CommentModel.fromJson(json))
        .toList();
  }

  Future<CommentModel> createComment(CommentModel comment) async {
    final response = await _dio.post(
      '/rest/v1/comments',
      data: comment.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return CommentModel.fromJson(response.data[0]);
  }

  Future<void> deleteComment(String commentId) async {
    await _dio.delete(
      '/rest/v1/comments',
      queryParameters: {
        'id': 'eq.$commentId',
      },
    );
  }

  // =========================
  // LIKES
  // =========================

  Future<bool> isPostLiked(
    String userId,
    String postId,
  ) async {
    final response = await _dio.get(
      '/rest/v1/likes',
      queryParameters: {
        'user_id': 'eq.$userId',
        'post_id': 'eq.$postId',
        'select': '*',
      },
    );

    return (response.data as List).isNotEmpty;
  }

  Future<LikeModel> likePost(LikeModel like) async {
    final response = await _dio.post(
      '/rest/v1/likes',
      data: like.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return LikeModel.fromJson(response.data[0]);
  }

  Future<void> unlikePost(
    String userId,
    String postId,
  ) async {
    await _dio.delete(
      '/rest/v1/likes',
      queryParameters: {
        'user_id': 'eq.$userId',
        'post_id': 'eq.$postId',
      },
    );
  }

  // =========================
  // FOLLOWS
  // =========================

  Future<List<FollowModel>> getFollowers(String userId) async {
    final response = await _dio.get(
      '/rest/v1/follows',
      queryParameters: {
        'following_id': 'eq.$userId',
        'select': '*',
      },
    );

    return (response.data as List)
        .map((json) => FollowModel.fromJson(json))
        .toList();
  }

  Future<List<FollowModel>> getFollowing(String userId) async {
    final response = await _dio.get(
      '/rest/v1/follows',
      queryParameters: {
        'follower_id': 'eq.$userId',
        'select': '*',
      },
    );

    return (response.data as List)
        .map((json) => FollowModel.fromJson(json))
        .toList();
  }

  Future<FollowModel> followUser(FollowModel follow) async {
    final response = await _dio.post(
      '/rest/v1/follows',
      data: follow.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return FollowModel.fromJson(response.data[0]);
  }

  Future<void> unfollowUser(
    String followerId,
    String followingId,
  ) async {
    await _dio.delete(
      '/rest/v1/follows',
      queryParameters: {
        'follower_id': 'eq.$followerId',
        'following_id': 'eq.$followingId',
      },
    );
  }

  // =========================
  // STORIES
  // =========================

  Future<List<StoryModel>> getActiveStories() async {
    final response = await _dio.get(
      '/rest/v1/stories',
      queryParameters: {
        'expires_at': 'gt.${DateTime.now().toIso8601String()}',
        'select': '*',
        'order': 'created_at.desc',
      },
    );

    return (response.data as List)
        .map((json) => StoryModel.fromJson(json))
        .toList();
  }

  Future<List<StoryModel>> getUserStories(String userId) async {
    final response = await _dio.get(
      '/rest/v1/stories',
      queryParameters: {
        'user_id': 'eq.$userId',
        'expires_at': 'gt.${DateTime.now().toIso8601String()}',
        'select': '*',
        'order': 'created_at.asc',
      },
    );

    return (response.data as List)
        .map((json) => StoryModel.fromJson(json))
        .toList();
  }

  Future<StoryModel> createStory(StoryModel story) async {
    final response = await _dio.post(
      '/rest/v1/stories',
      data: story.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return StoryModel.fromJson(response.data[0]);
  }

  Future<void> deleteStory(String storyId) async {
    await _dio.delete(
      '/rest/v1/stories',
      queryParameters: {
        'id': 'eq.$storyId',
      },
    );
  }

  // =========================
  // STORY VIEWS
  // =========================

  Future<bool> hasViewedStory(
    String storyId,
    String userId,
  ) async {
    final response = await _dio.get(
      '/rest/v1/story_views',
      queryParameters: {
        'story_id': 'eq.$storyId',
        'user_id': 'eq.$userId',
        'select': '*',
      },
    );

    return (response.data as List).isNotEmpty;
  }

  Future<StoryViewModel> addStoryView(
    StoryViewModel view,
  ) async {
    final response = await _dio.post(
      '/rest/v1/story_views',
      data: view.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return StoryViewModel.fromJson(response.data[0]);
  }

  // =========================
  // CONVERSATIONS
  // =========================

  Future<List<ConversationModel>> getUserConversations(
    String userId,
  ) async {
    final response = await _dio.get(
      '/rest/v1/conversation_members',
      queryParameters: {
        'user_id': 'eq.$userId',
        'select': 'conversation_id,conversations(*)',
      },
    );

    return (response.data as List)
        .map(
          (json) => ConversationModel.fromJson(
            json['conversations'],
          ),
        )
        .toList();
  }

  Future<List<ConversationMemberModel>> getConversationMembers(
    String conversationId,
  ) async {
    final response = await _dio.get(
      '/rest/v1/conversation_members',
      queryParameters: {
        'conversation_id': 'eq.$conversationId',
        'select': '*',
      },
    );

    return (response.data as List)
        .map((json) => ConversationMemberModel.fromJson(json))
        .toList();
  }

  Future<ConversationModel> createConversation(
    ConversationModel conversation,
  ) async {
    final response = await _dio.post(
      '/rest/v1/conversations',
      data: conversation.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return ConversationModel.fromJson(response.data[0]);
  }

  Future<ConversationMemberModel> addConversationMember(
    ConversationMemberModel member,
  ) async {
    final response = await _dio.post(
      '/rest/v1/conversation_members',
      data: member.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return ConversationMemberModel.fromJson(response.data[0]);
  }

  // =========================
  // MESSAGES
  // =========================

  Future<List<MessageModel>> getMessages(
    String conversationId,
  ) async {
    final response = await _dio.get(
      '/rest/v1/messages',
      queryParameters: {
        'conversation_id': 'eq.$conversationId',
        'select': '*',
        'order': 'created_at.asc',
      },
    );

    return (response.data as List)
        .map((json) => MessageModel.fromJson(json))
        .toList();
  }

  Future<MessageModel> sendMessage(MessageModel message) async {
    final response = await _dio.post(
      '/rest/v1/messages',
      data: message.toJson(),
      options: Options(
        headers: {
          'Prefer': 'return=representation',
        },
      ),
    );

    return MessageModel.fromJson(response.data[0]);
  }

  Future<void> deleteMessage(String messageId) async {
    await _dio.delete(
      '/rest/v1/messages',
      queryParameters: {
        'id': 'eq.$messageId',
      },
    );
  }

  AppFailure mapDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.badCertificate => const BadCertificateFailure(),

      DioExceptionType.badResponse => const ServerFailure(),

      DioExceptionType.cancel => const RequestCancelledFailure(),

      DioExceptionType.connectionError => const NetworkFailure(),

      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.transformTimeout => const TimeoutFailure(),

      DioExceptionType.unknown => const UnknownFailure(),
    };
  }
}
