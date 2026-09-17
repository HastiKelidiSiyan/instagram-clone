import 'package:dio/dio.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_members_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/follows_model.dart';

class RemoteDataSource {
  final Dio _dio;

  RemoteDataSource([Dio? dio]) : _dio = dio ?? Dio(BaseOptions(
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  )) {
    // Only add the logging interceptor when we constructed the Dio here.
    if (dio == null) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (log) => print('[Dio] $log'),
        ),
      );
    }
  }

  static const String usersAndStoriesBaseUrl =
      'https://695438ec1cd5294d2c7c33d5.mockapi.io';
  static const String postsAndMessagesBaseUrl =
      'https://69543dae1cd5294d2c7c3e3a.mockapi.io';
  static const String currentUserBaseUrl =
      'https://695458e61cd5294d2c7c7147.mockapi.io';

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/posts?select=*&order=created_at.desc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<PostModel?> getPostById(int postId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/posts?id=eq.$postId');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return PostModel.fromJson(data[0]);
        if (data is Map) return PostModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to load post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<PostModel>> getPostsByUser(int userId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/posts?user_id=eq.$userId&order=created_at.desc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load posts for user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<PostModel?> createPost(PostModel post) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/posts', data: post.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return PostModel.fromJson(data[0]);
        if (data is Map) return PostModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to create post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> deletePost(int postId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/posts?id=eq.$postId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<MessageModel>> getMessages() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/messages');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MessageModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load messages');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<StoryModel>> getStories() async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/stories');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => StoryModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load stories');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/users?select=*');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load users');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/users?id=eq.$id');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return UserModel.fromJson(data[0]);
        if (data is Map) return UserModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to load user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final response = await _dio.get(
        '$usersAndStoriesBaseUrl/rest/v1/users?username=ilike.*$username*',
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return UserModel.fromJson(data[0]);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to load user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<UserModel?> addUser(UserModel user) async {
    try {
      final response = await _dio.post('$usersAndStoriesBaseUrl/rest/v1/users', data: user.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return UserModel.fromJson(data[0]);
        if (data is Map) return UserModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to add user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<UserModel?> updateUserProfile(int userId, Map<String, dynamic> updates) async {
    try {
      final response = await _dio.patch('$usersAndStoriesBaseUrl/rest/v1/users?id=eq.$userId', data: updates);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return UserModel.fromJson(data[0]);
        if (data is Map) return UserModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to update user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<StoryViewModel>> getStoryViews() async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/story_views');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => StoryViewModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load story views');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/conversations');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ConversationModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load conversations');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<ConverstionMembersModel>> getConversationMembers() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/conversation_members');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ConverstionMembersModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load conversation members');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<PostMediaModel>> getPostMedia() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/post_media');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostMediaModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load post media');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<CommentsModel>> getComments() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/comments');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CommentsModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load comments');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<LikeModel>> getLikes() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/likes');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => LikeModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load likes');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<FollowsModel>> getFollows() async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/follows');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => FollowsModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load follows');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Post media
  Future<List<PostMediaModel>> getPostMediaByPostId(int postId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/post_media?post_id=eq.$postId&order=position.asc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostMediaModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load post media for post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<PostMediaModel?> addPostMedia(PostMediaModel media) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/post_media', data: media.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return PostMediaModel.fromJson(data[0]);
        if (data is Map) return PostMediaModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to add post media');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> deletePostMedia(int mediaId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/post_media?id=eq.$mediaId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Comments
  Future<List<CommentsModel>> getCommentsForPost(int postId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/comments?post_id=eq.$postId&order=created_at.asc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CommentsModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load comments for post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<CommentsModel?> createComment(CommentsModel comment) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/comments', data: comment.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return CommentsModel.fromJson(data[0]);
        if (data is Map) return CommentsModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to create comment');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> deleteComment(int commentId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/comments?id=eq.$commentId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Likes
  Future<bool> hasLikedPost(int postId, int userId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/likes?post_id=eq.$postId&user_id=eq.$userId');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return true;
        return false;
      } else {
        throw Exception('${response.statusCode}: Failed to check like');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<LikeModel?> likePost(LikeModel like) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/likes', data: like.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return LikeModel.fromJson(data[0]);
        if (data is Map) return LikeModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to like post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> unlikePost(int postId, int userId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/likes?post_id=eq.$postId&user_id=eq.$userId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Follows
  Future<List<FollowsModel>> getFollowersForUser(int userId) async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/follows?following_id=eq.$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => FollowsModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load followers');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<FollowsModel>> getFollowingForUser(int userId) async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/follows?follower_id=eq.$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => FollowsModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load following');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<FollowsModel?> followUser(FollowsModel follow) async {
    try {
      final response = await _dio.post('$usersAndStoriesBaseUrl/rest/v1/follows', data: follow.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return FollowsModel.fromJson(data[0]);
        if (data is Map) return FollowsModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to follow user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> unfollowUser(int followerId, int followingId) async {
    try {
      final response = await _dio.delete('$usersAndStoriesBaseUrl/rest/v1/follows?follower_id=eq.$followerId&following_id=eq.$followingId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Stories
  Future<List<StoryModel>> getActiveStories() async {
    try {
      final now = DateTime.now().toIso8601String();
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/stories?expires_at=gt.$now&order=created_at.desc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => StoryModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load active stories');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<StoryModel>> getStoriesByUser(int userId) async {
    try {
      final now = DateTime.now().toIso8601String();
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/stories?user_id=eq.$userId&expires_at=gt.$now&order=created_at.desc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => StoryModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load user stories');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<StoryModel?> createStory(StoryModel story) async {
    try {
      final response = await _dio.post('$usersAndStoriesBaseUrl/rest/v1/stories', data: story.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return StoryModel.fromJson(data[0]);
        if (data is Map) return StoryModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to create story');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> deleteStory(int storyId) async {
    try {
      final response = await _dio.delete('$usersAndStoriesBaseUrl/rest/v1/stories?id=eq.$storyId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Story views
  Future<List<StoryViewModel>> getViewsForStory(int storyId) async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/story_views?story_id=eq.$storyId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => StoryViewModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load story views');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> hasViewedStory(int storyId, int userId) async {
    try {
      final response = await _dio.get('$usersAndStoriesBaseUrl/rest/v1/story_views?story_id=eq.$storyId&user_id=eq.$userId');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return true;
        return false;
      } else {
        throw Exception('${response.statusCode}: Failed to check story view');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<StoryViewModel?> addStoryView(StoryViewModel view) async {
    try {
      final response = await _dio.post('$usersAndStoriesBaseUrl/rest/v1/story_views', data: view.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return StoryViewModel.fromJson(data[0]);
        if (data is Map) return StoryViewModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to add story view');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Saved posts
  Future<List<PostModel>> getSavedPosts(int userId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/saved_posts?user_id=eq.$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load saved posts');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> isPostSaved(int userId, int postId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/saved_posts?user_id=eq.$userId&post_id=eq.$postId');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return true;
        return false;
      } else {
        throw Exception('${response.statusCode}: Failed to check saved post');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> savePost(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/saved_posts', data: payload);
      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> unsavePost(int userId, int postId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/saved_posts?user_id=eq.$userId&post_id=eq.$postId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Conversations
  Future<List<ConversationModel>> getConversationsForUser(int userId) async {
    try {
      final membersResp = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/conversation_members?user_id=eq.$userId&select=conversation_id');
      if (membersResp.statusCode != 200) throw Exception('${membersResp.statusCode}: Failed to load conversation members');
      final memberData = membersResp.data as List<dynamic>;
      final ids = memberData.map((e) => e['conversation_id']).whereType<int>().toList();
      if (ids.isEmpty) return [];
      final idList = ids.join(',');
      final convResp = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/conversations?id=in.($idList)');
      if (convResp.statusCode == 200) {
        final List<dynamic> data = convResp.data;
        return data.map((json) => ConversationModel.fromJson(json)).toList();
      }
      throw Exception('${convResp.statusCode}: Failed to load conversations');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ConverstionMembersModel?> addConversationMember(ConverstionMembersModel member) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/conversation_members', data: member.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return ConverstionMembersModel.fromJson(data[0]);
        if (data is Map) return ConverstionMembersModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to add conversation member');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<ConversationModel?> createConversation(ConversationModel conversation) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/conversations', data: conversation.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return ConversationModel.fromJson(data[0]);
        if (data is Map) return ConversationModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to create conversation');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<List<ConverstionMembersModel>> getMembersForConversation(int conversationId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/conversation_members?conversation_id=eq.$conversationId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ConverstionMembersModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load conversation members');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  // Messages
  Future<List<MessageModel>> getMessagesForConversation(int conversationId) async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/rest/v1/messages?conversation_id=eq.$conversationId&order=created_at.asc');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MessageModel.fromJson(json)).toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load messages for conversation');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<MessageModel?> sendMessage(MessageModel message) async {
    try {
      final response = await _dio.post('$postsAndMessagesBaseUrl/rest/v1/messages', data: message.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) return MessageModel.fromJson(data[0]);
        if (data is Map) return MessageModel.fromJson(data);
        return null;
      } else {
        throw Exception('${response.statusCode}: Failed to send message');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<bool> deleteMessage(int messageId) async {
    try {
      final response = await _dio.delete('$postsAndMessagesBaseUrl/rest/v1/messages?id=eq.$messageId');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  AppFailure mapDioException(DioException exception) {
  return switch (exception.type) {
    DioExceptionType.badCertificate =>
      const BadCertificateFailure(),

    DioExceptionType.badResponse =>
      const ServerFailure(),

    DioExceptionType.cancel =>
      const RequestCancelledFailure(),

    DioExceptionType.connectionError =>
      const NetworkFailure(),

    DioExceptionType.connectionTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.transformTimeout =>
      const TimeoutFailure(),

    DioExceptionType.unknown =>
      const UnknownFailure(),
  };
}
}
