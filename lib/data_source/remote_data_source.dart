import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/core/network/dio_client.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/domain/message_with_sender.dart';
import 'package:instagram_clone/models/domain/post_with_media.dart';
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
import 'package:instagram_clone/models/domain/post_item.dart';
import 'package:instagram_clone/models/domain/story_item_data.dart';
import 'package:instagram_clone/models/domain/profile_data.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';

class RemoteDataSource {
  final Dio _dio;

  RemoteDataSource([Dio? dio]) : _dio = dio ?? DioClient.dio;

  static const _profileSelect =
      'id,username,name,avatar_url,bio,created_at';

  Future<UserModel?> getUser(String userId) async {
    try {
      final response = await _dio.get(
        '/rest/v1/profiles',
        queryParameters: {
          'id': 'eq.$userId',
          'select': _profileSelect,
          'limit': 1,
        },
      );

      final profiles = response.data as List;

      if (profiles.isEmpty) {
        return null;
      }

      return UserModel.fromJson(
        Map<String, dynamic>.from(profiles.first),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  static const _profileDataSelect = '''
  id,
  username,
  name,
  avatar_url,
  bio,
  created_at,
  posts:posts!Posts_user_id_fkey(
    id,
    user_id,
    caption,
    created_at,
    media:post_media(
      id,
      post_id,
      media_url,
      media_type,
      position
    )
  ),
  followers:follows!follows_following_id_fkey(
    follower_id
  ),
  following:follows!follows_follower_id_fkey(
    following_id
  ),
  active_stories:stories!stories_user_id_fkey(
    id,
    user_id,
    media_url,
    media_type,
    created_at,
    expires_at
  )
''';

  Future<ProfileData?> getProfileData(
    String userId,
    String currentUserId,
  ) async {
    try {
      final response = await _dio.get(
        '/rest/v1/profiles',
        queryParameters: {
          'id': 'eq.$userId',
          'select': _compactSelect(_profileDataSelect),
          'posts.order': 'created_at.desc',
          'posts.media.order': 'position.asc',
          'active_stories.expires_at':
              'gt.${DateTime.now().toUtc().toIso8601String()}',
          'limit': 1,
        },
      );

      final profiles = response.data as List;

      if (profiles.isEmpty) {
        return null;
      }

      return ProfileData.fromJson(
        Map<String, dynamic>.from(profiles.first),
        currentUserId: currentUserId,
      );
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final response = await _dio.get(
        '/rest/v1/profiles',
        queryParameters: {
          'or': '(username.ilike.*$query*,name.ilike.*$query*)',
          'select': _profileSelect,
          'order': 'username.asc',
          'limit': 20,
        },
      );

      return (response.data as List)
          .map(
            (item) => UserModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await _dio.post(
        '/rest/v1/profiles',
        data: user.toJson(),
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  static const _feedSelect = '''
  id,
  user_id,
  caption,
  created_at,
  author:profiles!Posts_user_id_fkey(
    id,
    username,
    name,
    avatar_url,
    bio,
    created_at
  ),
  media:post_media(
    id,
    post_id,
    media_url,
    media_type,
    position
  ),
  likes(
    user_id,
    post_id,
    created_at,
    liker:profiles(
      id,
      username,
      name,
      avatar_url,
      bio,
      created_at
    )
  ),
  comments(
    id
  )
''';

  Future<List<PostItem>> getFeedItems(String currentUserId) async {
    try {
      final followsResponse = await _dio.get(
        '/rest/v1/follows',
        queryParameters: {
          'follower_id': 'eq.$currentUserId',
          'select': 'following_id',
        },
      );

      final feedUserIds = <String>{
        currentUserId,
        ...(followsResponse.data as List).map(
          (item) => item['following_id'].toString(),
        ),
      };

      final response = await _dio.get(
        '/rest/v1/posts',
        queryParameters: {
          'user_id': 'in.(${feedUserIds.join(',')})',
          'select': _compactSelect(_feedSelect),
          'order': 'created_at.desc',
          'media.order': 'position.asc',
          'likes.order': 'created_at.desc',
        },
      );

      return (response.data as List)
          .map(
            (item) => PostItem.fromJson(
              Map<String, dynamic>.from(item),
              currentUserId: currentUserId,
            ),
          )
          .toList();
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  static const _storySelect = '''
  id,
  user_id,
  media_url,
  media_type,
  created_at,
  expires_at,
  author:profiles!stories_user_id_fkey(
    id,
    username,
    name,
    avatar_url,
    bio,
    created_at
  ),
  views:story_views(
    user_id
  )
''';

  Future<List<StoryItemData>> getActiveStoryItems(
    String currentUserId,
  ) async {
    try {
      final followsResponse = await _dio.get(
        '/rest/v1/follows',
        queryParameters: {
          'follower_id': 'eq.$currentUserId',
          'select': 'following_id',
        },
      );

      final followingIds = (followsResponse.data as List)
          .map((item) => item['following_id'].toString())
          .toList();

      if (followingIds.isEmpty) {
        return [];
      }

      final response = await _dio.get(
        '/rest/v1/stories',
        queryParameters: {
          'user_id': 'in.(${followingIds.join(',')})',
          'expires_at': 'gt.${DateTime.now().toUtc().toIso8601String()}',
          'select': _compactSelect(_storySelect),
          'views.user_id': 'eq.$currentUserId',
          'order': 'created_at.desc',
        },
      );

      return (response.data as List).map((item) {
        final json = Map<String, dynamic>.from(item);
        final views = json['views'] as List<dynamic>? ?? [];

        return StoryItemData(
          story: StoryModel.fromJson(json),
          author: UserModel.fromJson(
            Map<String, dynamic>.from(json['author']),
          ),
          isViewedByCurrentUser: views.isNotEmpty,
        );
      }).toList();
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  Future<PostWithMedia> getPostWithMedia(String postId) async {
    try {
      final response = await _dio.get(
        '/rest/v1/posts',
        queryParameters: {
          'id': 'eq.$postId',
          'select': _compactSelect('''
          id,
          user_id,
          caption,
          created_at,
          media:post_media(
            id,
            post_id,
            media_url,
            media_type,
            position
          )
        '''),
          'media.order': 'position.asc',
        },
      );

      final rows = response.data as List;

      if (rows.isEmpty) {
        throw const ServerFailure();
      }

      return PostWithMedia.fromJson(
        Map<String, dynamic>.from(rows.first),
      );
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  Future<PostWithMedia> createPostWithMedia({
    required String caption,
    required List<Map<String, dynamic>> media,
  }) async {
    try {
      final response = await _dio.post(
        '/rest/v1/rpc/create_post_with_media',
        data: {
          'p_caption': caption,
          'p_media': media,
        },
      );

      return PostWithMedia.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _dio.delete(
        '/rest/v1/posts',
        queryParameters: {
          'id': 'eq.$postId',
        },
      );
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  static const _messageSelect = '''
  id,
  conversation_id,
  sender_id,
  text,
  created_at,
  sender:profiles(
    id,
    username,
    name,
    avatar_url,
    bio,
    created_at
  )
''';

  Future<List<MessageWithSender>> getConversationMessages(
    String conversationId, {
    int limit = 30,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get(
        '/rest/v1/messages',
        queryParameters: {
          'conversation_id': 'eq.$conversationId',
          'select': _compactSelect(_messageSelect),
          'order': 'created_at.desc',
          'limit': limit,
          'offset': offset,
        },
      );

      final messages = (response.data as List)
          .map(
            (item) => MessageWithSender.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      return messages.reversed.toList();
    } on DioException catch (exception) {
      throw mapDioException(exception);
    }
  }

  AppFailure mapDioException(DioException exception) {
    if (kDebugMode && exception.response != null) {
      debugPrint('Failed request: ${exception.requestOptions.uri}');
      debugPrint('Status code: ${exception.response?.statusCode}');
      debugPrint('Supabase response: ${exception.response?.data}');
    }

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

  String _compactSelect(String select) {
    return select.replaceAll(RegExp(r'\s+'), '');
  }
}
