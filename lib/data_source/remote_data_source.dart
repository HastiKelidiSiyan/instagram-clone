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
import 'package:instagram_clone/models/domain/home_post.dart';
import 'package:instagram_clone/models/domain/home_story.dart';
import 'package:instagram_clone/models/domain/conversation_preview.dart';
import 'package:instagram_clone/models/domain/profile_model.dart';

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

  Future<void> addUser(UserModel user) async {
    await _dio.post(
      '/rest/v1/users',
      data: {
        'id': user.id,
        'username': user.username,
        'name': user.name,
        'avatar_url': user.avatarUrl,
        'bio': user.bio,
        'created_at': user.createdAt.toIso8601String(),
      },
    );
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

  Future<List<MessageModel>> getConversationMessages(
    String conversationId,
  ) => getMessages(conversationId);

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
      queryParameters: {'id': 'eq.$messageId'},
    );
  }

  Future<List<StoryGroupModel>> getStoryGroups(String currentUserId) async {
    final followsResponse = await _dio.get(
      '/rest/v1/follows',
      queryParameters: {
        'follower_id': 'eq.$currentUserId',
        'select': 'following_id',
      },
    );

    final followingIds = (followsResponse.data as List)
        .map((row) => row['following_id'].toString())
        .toList();
    if (followingIds.isEmpty) return [];

    final response = await _dio.get(
      '/rest/v1/stories',
      queryParameters: {
        'user_id': 'in.(${followingIds.join(',')})',
        'expires_at': 'gt.${DateTime.now().toIso8601String()}',
        'select': '*,users(*)',
        'order': 'created_at.asc',
      },
    );

    final rows = response.data as List;
    final storiesByUserId = <String, List<StoryModel>>{};
    final usersById = <String, UserModel>{};
    for (final row in rows) {
      final story = StoryModel.fromJson(_storyJson(row));
      storiesByUserId.putIfAbsent(story.userId, () => []).add(story);
      final userRow = row['users'];
      if (userRow is Map<String, dynamic>) {
        final user = UserModel.fromJson(userRow);
        usersById[user.id] = user;
      }
    }

    return storiesByUserId.entries.map((entry) {
      final user = usersById[entry.key];
      if (user == null) throw const ServerFailure();
      return StoryGroupModel(user: user, stories: entry.value);
    }).toList();
  }

  Future<List<ConversationPreviewModel>> getConversationPreviews(
    String currentUserId,
  ) async {
    final membersResponse = await _dio.get(
      '/rest/v1/conversation_members',
      queryParameters: {
        'user_id': 'eq.$currentUserId',
        'select': 'conversation_id',
      },
    );
    final conversationIds = (membersResponse.data as List)
        .map((row) => row['conversation_id'].toString())
        .toList();
    if (conversationIds.isEmpty) return [];

    final idFilter = 'in.(${conversationIds.join(',')})';
    final responses = await Future.wait([
      _dio.get(
        '/rest/v1/conversations',
        queryParameters: {'id': idFilter, 'select': '*'},
      ),
      _dio.get(
        '/rest/v1/conversation_members',
        queryParameters: {
          'conversation_id': idFilter,
          'select': 'conversation_id,user_id,users(*)',
        },
      ),
      _dio.get(
        '/rest/v1/messages',
        queryParameters: {
          'conversation_id': idFilter,
          'select': '*',
          'order': 'created_at.desc',
        },
      ),
    ]);

    final conversations = (responses[0].data as List)
        .map((row) => ConversationModel.fromJson(_conversationJson(row)))
        .toList();
    final participantsByConversation = <String, List<UserModel>>{};
    final usersById = <String, UserModel>{};
    for (final row in responses[1].data as List) {
      final userRow = row['users'];
      if (userRow is! Map<String, dynamic>) continue;
      final user = UserModel.fromJson(userRow);
      usersById[user.id] = user;
      participantsByConversation
          .putIfAbsent(row['conversation_id'].toString(), () => [])
          .add(user);
    }

    final lastMessagesByConversation = <String, MessageModel>{};
    for (final row in responses[2].data as List) {
      final message = MessageModel.fromJson(row);
      lastMessagesByConversation.putIfAbsent(
        message.conversationId,
        () => message,
      );
    }

    final senderIds = lastMessagesByConversation.values
        .map((message) => message.senderId)
        .where((id) => !usersById.containsKey(id))
        .toSet();
    if (senderIds.isNotEmpty) {
      final sendersResponse = await _dio.get(
        '/rest/v1/users',
        queryParameters: {'id': 'in.(${senderIds.join(',')})', 'select': '*'},
      );
      for (final row in sendersResponse.data as List) {
        final user = UserModel.fromJson(row);
        usersById[user.id] = user;
      }
    }

    return conversations.map((conversation) {
      final message = lastMessagesByConversation[conversation.id];
      final sender = message == null ? null : usersById[message.senderId];
      if (message != null && sender == null) throw const ServerFailure();
      return ConversationPreviewModel(
        conversation: conversation,
        participants: participantsByConversation[conversation.id] ?? [],
        lastMessage: message == null
            ? null
            : MessageWithUserModel(message: message, sender: sender!),
      );
    }).toList();
  }

  Future<ProfileModel> getProfile(String userId) async {
    final userResponse = await _dio.get(
      '/rest/v1/users',
      queryParameters: {'id': 'eq.$userId', 'select': '*'},
    );
    final userRows = userResponse.data as List;
    if (userRows.isEmpty) throw const ServerFailure();

    final results = await Future.wait([
      _dio.get(
        '/rest/v1/stories',
        queryParameters: {
          'user_id': 'eq.$userId',
          'expires_at': 'gt.${DateTime.now().toIso8601String()}',
          'select': '*',
          'order': 'created_at.asc',
        },
      ),
      _dio.get(
        '/rest/v1/posts',
        queryParameters: {
          'user_id': 'eq.$userId',
          'select': '*,users(*)',
          'order': 'created_at.desc',
        },
      ),
    ]);

    final stories = (results[0].data as List)
        .map((row) => StoryModel.fromJson(_storyJson(row)))
        .toList();
    final postRows = results[1].data as List;
    final posts = postRows.map((row) => PostModel.fromJson(row)).toList();
    if (posts.isEmpty) {
      return ProfileModel(
        user: UserModel.fromJson(userRows.first),
        stories: stories,
        posts: [],
      );
    }

    final postIdFilter = 'in.(${posts.map((post) => post.id).join(',')})';
    final detailResponses = await Future.wait([
      _dio.get(
        '/rest/v1/post_media',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'position.asc',
        },
      ),
      _dio.get(
        '/rest/v1/likes',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'created_at.desc',
        },
      ),
      _dio.get(
        '/rest/v1/comments',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'created_at.asc',
        },
      ),
    ]);

    final media = (detailResponses[0].data as List)
        .map((row) => PostMediaModel.fromJson(row))
        .toList();
    final likes = (detailResponses[1].data as List)
        .map((row) => LikeModel.fromJson(_likeJson(row)))
        .toList();
    final comments = (detailResponses[2].data as List)
        .map((row) => CommentModel.fromJson(row))
        .toList();
    final usersById = <String, UserModel>{
      userId: UserModel.fromJson(userRows.first),
    };
    final relatedUserIds = {
      ...likes.map((like) => like.userId),
      ...comments.map((comment) => comment.userId),
    }..remove(userId);
    if (relatedUserIds.isNotEmpty) {
      final relatedUsersResponse = await _dio.get(
        '/rest/v1/users',
        queryParameters: {
          'id': 'in.(${relatedUserIds.join(',')})',
          'select': '*',
        },
      );
      for (final row in relatedUsersResponse.data as List) {
        final user = UserModel.fromJson(row);
        usersById[user.id] = user;
      }
    }

    return ProfileModel(
      user: UserModel.fromJson(userRows.first),
      stories: stories,
      posts: posts.map((post) {
        final postRow = postRows.firstWhere(
          (row) => row['id'].toString() == post.id,
        );
        final author = UserModel.fromJson(postRow['users']);
        return HomePostModel(
          post: post,
          author: author,
          media: media.where((item) => item.postId == post.id).toList(),
          likes: likes.where((like) => like.postId == post.id).map((like) {
            final likeUser = usersById[like.userId];
            if (likeUser == null) throw const ServerFailure();
            return LikeWithUserModel(like: like, user: likeUser);
          }).toList(),
          comments: comments.where((comment) => comment.postId == post.id).map((
            comment,
          ) {
            final commentUser = usersById[comment.userId];
            if (commentUser == null) throw const ServerFailure();
            return CommentWithUserModel(comment: comment, user: commentUser);
          }).toList(),
        );
      }).toList(),
    );
  }

  Map<String, dynamic> _storyJson(Map<String, dynamic> json) => {
    ...json,
    'userId': json['userId'] ?? json['user_id'],
    'mediaUrl': json['mediaUrl'] ?? json['media_url'],
    'mediaType': json['mediaType'] ?? json['media_type'],
    'createdAt': json['createdAt'] ?? json['created_at'],
    'expiresAt': json['expiresAt'] ?? json['expires_at'],
  };

  Map<String, dynamic> _conversationJson(Map<String, dynamic> json) => {
    ...json,
    'createdAt': json['createdAt'] ?? json['created_at'],
  };

  Map<String, dynamic> _likeJson(Map<String, dynamic> json) => {
    ...json,
    'userId': json['userId'] ?? json['user_id'],
    'postId': json['postId'] ?? json['post_id'],
    'createdAt': json['createdAt'] ?? json['created_at'],
  };

  Future<List<HomePostModel>> getHomePosts(String currentUserId) async {
    final followsResponse = await _dio.get(
      '/rest/v1/follows',
      queryParameters: {
        'follower_id': 'eq.$currentUserId',
        'select': 'following_id',
      },
    );

    final followingIds = (followsResponse.data as List)
        .map((json) => json['following_id'].toString())
        .toList();
    if (followingIds.isEmpty) return [];

    final postsResponse = await _dio.get(
      '/rest/v1/posts',
      queryParameters: {
        'user_id': 'in.(${followingIds.join(',')})',
        'select': '*,users(*)',
        'order': 'created_at.desc',
      },
    );

    final postRows = postsResponse.data as List;
    if (postRows.isEmpty) return [];

    final posts = postRows.map((row) => PostModel.fromJson(row)).toList();
    final postIds = posts.map((post) => post.id).toList();
    final postIdFilter = 'in.(${postIds.join(',')})';

    final results = await Future.wait([
      _dio.get(
        '/rest/v1/post_media',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'position.asc',
        },
      ),
      _dio.get(
        '/rest/v1/likes',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'created_at.desc',
        },
      ),
      _dio.get(
        '/rest/v1/comments',
        queryParameters: {
          'post_id': postIdFilter,
          'select': '*',
          'order': 'created_at.asc',
        },
      ),
    ]);

    final media = (results[0].data as List)
        .map((row) => PostMediaModel.fromJson(row))
        .toList();
    final likes = (results[1].data as List)
        .map(
          (row) => LikeModel.fromJson({
            ...row,
            'userId': row['userId'] ?? row['user_id'],
            'postId': row['postId'] ?? row['post_id'],
            'createdAt': row['createdAt'] ?? row['created_at'],
          }),
        )
        .toList();
    final comments = (results[2].data as List)
        .map((row) => CommentModel.fromJson(row))
        .toList();

    final authorRows = postRows
        .map((row) => row['users'])
        .whereType<Map<String, dynamic>>()
        .toList();
    final userRows = <Map<String, dynamic>>[...authorRows];
    final relatedUserIds = {
      ...likes.map((like) => like.userId),
      ...comments.map((comment) => comment.userId),
    }.toSet();

    if (relatedUserIds.isNotEmpty) {
      final usersResponse = await _dio.get(
        '/rest/v1/users',
        queryParameters: {
          'id': 'in.(${relatedUserIds.join(',')})',
          'select': '*',
        },
      );
      userRows.addAll(
        (usersResponse.data as List).cast<Map<String, dynamic>>(),
      );
    }

    final usersById = <String, UserModel>{};
    for (final row in userRows) {
      final user = UserModel.fromJson(row);
      usersById[user.id] = user;
    }

    return posts.map((post) {
      final authorRow = postRows.firstWhere(
        (row) => row['id'].toString() == post.id,
      )['users'];
      final author = authorRow is Map<String, dynamic>
          ? UserModel.fromJson(authorRow)
          : usersById[post.userId];

      if (author == null) {
        throw const ServerFailure();
      }

      return HomePostModel(
        post: post,
        author: author,
        media: media.where((item) => item.postId == post.id).toList(),
        likes: likes.where((like) => like.postId == post.id).map((like) {
          final user = usersById[like.userId];
          if (user == null) throw const ServerFailure();
          return LikeWithUserModel(like: like, user: user);
        }).toList(),
        comments: comments.where((comment) => comment.postId == post.id).map((
          comment,
        ) {
          final user = usersById[comment.userId];
          if (user == null) throw const ServerFailure();
          return CommentWithUserModel(comment: comment, user: user);
        }).toList(),
      );
    }).toList();
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
