import 'package:drift/drift.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';
import 'package:instagram_clone/models/domain/conversation_preview.dart';
import 'package:instagram_clone/models/domain/home_post.dart';
import 'package:instagram_clone/models/domain/home_story.dart';
import 'package:instagram_clone/models/domain/profile_model.dart';
import 'package:instagram_clone/models/follow_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource([AppDatabase? database])
    : _database = database ?? AppDatabase.instance;

  Future<List<StoryGroupModel>> getStoryGroups(String currentUserId) async {
    final follows = await (_database.select(
      _database.follows,
    )..where((row) => row.followerId.equals(currentUserId))).get();
    final followingIds = follows.map((row) => row.followingId).toSet();
    if (followingIds.isEmpty) return [];

    final activeStories =
        await (_database.select(_database.stories)
              ..where(
                (row) =>
                    row.userId.isIn(followingIds) &
                    row.expiresAt.isBiggerThanValue(DateTime.now()),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();

    final grouped = <String, List<StoryModel>>{};
    for (final story in activeStories) {
      grouped.putIfAbsent(story.userId, () => []).add(_storyModel(story));
    }

    final users = await (_database.select(
      _database.users,
    )..where((row) => row.id.isIn(grouped.keys))).get();
    final usersById = {for (final user in users) user.id: _userModel(user)};

    return grouped.entries.map((entry) {
      final user = usersById[entry.key];
      if (user == null) throw StateError('Cached story author is missing.');
      return StoryGroupModel(user: user, stories: entry.value);
    }).toList();
  }

  Future<List<ConversationPreviewModel>> getConversationPreviews(
    String currentUserId,
  ) async {
    final membershipRows = await (_database.select(
      _database.conversationMembers,
    )..where((row) => row.userId.equals(currentUserId))).get();
    final conversationIds = membershipRows
        .map((row) => row.conversationId)
        .toSet();
    if (conversationIds.isEmpty) return [];

    final conversations = await (_database.select(
      _database.conversations,
    )..where((row) => row.id.isIn(conversationIds))).get();
    final members = await (_database.select(
      _database.conversationMembers,
    )..where((row) => row.conversationId.isIn(conversationIds))).get();
    final participantIds = members.map((member) => member.userId).toSet();
    final users = await (_database.select(
      _database.users,
    )..where((row) => row.id.isIn(participantIds))).get();
    final usersById = {for (final user in users) user.id: _userModel(user)};

    final messages =
        await (_database.select(_database.messages)
              ..where((row) => row.conversationId.isIn(conversationIds))
              ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
            .get();
    final latestMessages = <String, MessageModel>{};
    for (final message in messages) {
      latestMessages.putIfAbsent(
        message.conversationId,
        () => _messageModel(message),
      );
    }

    return conversations.map((conversation) {
      final conversationParticipants = members
          .where((member) => member.conversationId == conversation.id)
          .map((member) => usersById[member.userId])
          .whereType<UserModel>()
          .toList();
      final message = latestMessages[conversation.id];
      final sender = message == null ? null : usersById[message.senderId];
      if (message != null && sender == null) {
        throw StateError('Cached message sender is missing.');
      }
      return ConversationPreviewModel(
        conversation: _conversationModel(conversation),
        participants: conversationParticipants,
        lastMessage: message == null
            ? null
            : MessageWithUserModel(message: message, sender: sender!),
      );
    }).toList();
  }

  Future<ProfileModel> getProfile(String userId) async {
    final userRow = await (_database.select(
      _database.users,
    )..where((row) => row.id.equals(userId))).getSingleOrNull();
    if (userRow == null) throw StateError('Cached profile user is missing.');

    final now = DateTime.now();
    final stories =
        await (_database.select(_database.stories)
              ..where(
                (row) =>
                    row.userId.equals(userId) &
                    row.expiresAt.isBiggerThanValue(now),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
    final postRows =
        await (_database.select(_database.posts)
              ..where((row) => row.userId.equals(userId))
              ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
            .get();
    final postIds = postRows.map((post) => post.id).toSet();

    final mediaRows = postIds.isEmpty
        ? <PostMediaData>[]
        : await (_database.select(_database.postMedia)
                ..where((row) => row.postId.isIn(postIds))
                ..orderBy([(row) => OrderingTerm.asc(row.position)]))
              .get();
    final likeRows = postIds.isEmpty
        ? <Like>[]
        : await (_database.select(
            _database.likes,
          )..where((row) => row.postId.isIn(postIds))).get();
    final commentRows = postIds.isEmpty
        ? <Comment>[]
        : await (_database.select(_database.comments)
                ..where((row) => row.postId.isIn(postIds))
                ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
              .get();

    final relatedUserIds = {
      ...likeRows.map((row) => row.userId),
      ...commentRows.map((row) => row.userId),
      userId,
    };
    final relatedUsers = await (_database.select(
      _database.users,
    )..where((row) => row.id.isIn(relatedUserIds))).get();
    final usersById = {
      for (final user in relatedUsers) user.id: _userModel(user),
    };

    final homePosts = postRows.map((postRow) {
      final post = _postModel(postRow);
      final author = usersById[post.userId];
      if (author == null) throw StateError('Cached post author is missing.');
      final likes = likeRows.where((row) => row.postId == post.id).map((row) {
        final likeUser = usersById[row.userId];
        if (likeUser == null) throw StateError('Cached like user is missing.');
        return LikeWithUserModel(like: _likeModel(row), user: likeUser);
      }).toList();
      final comments = commentRows.where((row) => row.postId == post.id).map((
        row,
      ) {
        final commentUser = usersById[row.userId];
        if (commentUser == null) {
          throw StateError('Cached comment user is missing.');
        }
        return CommentWithUserModel(
          comment: _commentModel(row),
          user: commentUser,
        );
      }).toList();

      return HomePostModel(
        post: post,
        author: author,
        media: mediaRows
            .where((row) => row.postId == post.id)
            .map(_postMediaModel)
            .toList(),
        likes: likes,
        comments: comments,
      );
    }).toList();

    return ProfileModel(
      user: _userModel(userRow),
      stories: stories.map(_storyModel).toList(),
      posts: homePosts,
    );
  }

  Future<List<HomePostModel>> getHomePosts(String currentUserId) async {
    final follows = await (_database.select(
      _database.follows,
    )..where((row) => row.followerId.equals(currentUserId))).get();
    final followingIds = follows.map((row) => row.followingId).toSet();
    if (followingIds.isEmpty) return [];

    final postRows =
        await (_database.select(_database.posts)
              ..where((row) => row.userId.isIn(followingIds))
              ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
            .get();
    final postIds = postRows.map((post) => post.id).toSet();
    if (postIds.isEmpty) return [];

    final mediaRows =
        await (_database.select(_database.postMedia)
              ..where((row) => row.postId.isIn(postIds))
              ..orderBy([(row) => OrderingTerm.asc(row.position)]))
            .get();
    final likeRows =
        await (_database.select(_database.likes)
              ..where((row) => row.postId.isIn(postIds))
              ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
            .get();
    final commentRows =
        await (_database.select(_database.comments)
              ..where((row) => row.postId.isIn(postIds))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();

    final userIds = {
      ...postRows.map((row) => row.userId),
      ...likeRows.map((row) => row.userId),
      ...commentRows.map((row) => row.userId),
    };
    final userRows = await (_database.select(
      _database.users,
    )..where((row) => row.id.isIn(userIds))).get();
    final usersById = {for (final row in userRows) row.id: _userModel(row)};

    return postRows.map((postRow) {
      final post = _postModel(postRow);
      final author = usersById[post.userId];
      if (author == null) throw StateError('Cached post author is missing.');
      return HomePostModel(
        post: post,
        author: author,
        media: mediaRows
            .where((row) => row.postId == post.id)
            .map((row) => _postMediaModel(row))
            .toList(),
        likes: likeRows.where((row) => row.postId == post.id).map((row) {
          final user = usersById[row.userId];
          if (user == null) throw StateError('Cached like user is missing.');
          return LikeWithUserModel(like: _likeModel(row), user: user);
        }).toList(),
        comments: commentRows.where((row) => row.postId == post.id).map((row) {
          final user = usersById[row.userId];
          if (user == null) {
            throw StateError('Cached comment user is missing.');
          }
          return CommentWithUserModel(
            comment: _commentModel(row),
            user: user,
          );
        }).toList(),
      );
    }).toList();
  }

  Future<List<UserModel>> searchUsers(String query) async {
    final rows = await (_database.select(
      _database.users,
    )..where((row) => row.username.like('%$query%'))).get();
    return rows.map(_userModel).toList();
  }

  Future<UserModel> getUser(String userId) async => _userModel(
    await (_database.select(
      _database.users,
    )..where((row) => row.id.equals(userId))).getSingle(),
  );

  Future<void> cacheUser(UserModel model) async {
    await _database
        .into(_database.users)
        .insertOnConflictUpdate(
          UsersCompanion.insert(
            id: model.id,
            username: model.username,
            name: model.name,
            avatarUrl: Value(model.avatarUrl),
            bio: Value(model.bio),
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await (_database.update(
      _database.users,
    )..where((row) => row.id.equals(userId))).write(
      UsersCompanion(
        username: data['username'] == null
            ? const Value.absent()
            : Value(data['username'] as String),
        name: data['name'] == null
            ? const Value.absent()
            : Value(data['name'] as String),
        avatarUrl: data['avatar_url'] == null
            ? const Value.absent()
            : Value(data['avatar_url'] as String?),
        bio: data['bio'] == null
            ? const Value.absent()
            : Value(data['bio'] as String?),
      ),
    );
  }

  Future<List<PostModel>> getUserPosts(String userId) async {
    final rows =
        await (_database.select(_database.posts)
              ..where((row) => row.userId.equals(userId))
              ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
            .get();
    return rows.map(_postModel).toList();
  }

  Future<PostModel> getPost(String postId) async => _postModel(
    await (_database.select(
      _database.posts,
    )..where((row) => row.id.equals(postId))).getSingle(),
  );

  Future<void> createPost(PostModel model) async => cachePost(model);

  Future<void> cachePost(PostModel model) async {
    await _database
        .into(_database.posts)
        .insertOnConflictUpdate(
          PostsCompanion.insert(
            id: model.id,
            userId: model.userId,
            caption: model.caption,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> deletePost(String postId) async {
    await (_database.delete(
      _database.posts,
    )..where((row) => row.id.equals(postId))).go();
  }

  Future<List<PostMediaModel>> getPostMedia(String postId) async {
    final rows =
        await (_database.select(_database.postMedia)
              ..where((row) => row.postId.equals(postId))
              ..orderBy([(row) => OrderingTerm.asc(row.position)]))
            .get();
    return rows.map(_postMediaModel).toList();
  }

  Future<void> createPostMedia(PostMediaModel model) async =>
      cachePostMedia(model);

  Future<void> cachePostMedia(PostMediaModel model) async {
    await _database
        .into(_database.postMedia)
        .insertOnConflictUpdate(
          PostMediaCompanion.insert(
            id: model.id,
            postId: model.postId,
            mediaUrl: model.mediaUrl,
            mediaType: model.mediaType,
            position: model.position,
          ),
        );
  }

  Future<void> deletePostMedia(String mediaId) async {
    await (_database.delete(
      _database.postMedia,
    )..where((row) => row.id.equals(mediaId))).go();
  }

  Future<List<CommentModel>> getComments(String postId) async {
    final rows =
        await (_database.select(_database.comments)
              ..where((row) => row.postId.equals(postId))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
    return rows.map(_commentModel).toList();
  }

  Future<void> createComment(CommentModel model) async {
    await _database
        .into(_database.comments)
        .insertOnConflictUpdate(
          CommentsCompanion.insert(
            id: model.id,
            postId: model.postId,
            userId: model.userId,
            textContent: model.text,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> cacheComment(CommentModel model) => createComment(model);

  Future<void> deleteComment(String commentId) async {
    await (_database.delete(
      _database.comments,
    )..where((row) => row.id.equals(commentId))).go();
  }

  Future<bool> isPostLiked(String userId, String postId) async {
    final row =
        await (_database.select(_database.likes)..where(
              (like) => like.userId.equals(userId) & like.postId.equals(postId),
            ))
            .getSingleOrNull();
    return row != null;
  }

  Future<void> likePost(LikeModel model) async {
    await _database
        .into(_database.likes)
        .insertOnConflictUpdate(
          LikesCompanion.insert(
            id: model.id,
            userId: model.userId,
            postId: model.postId,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> cacheLike(LikeModel model) => likePost(model);

  Future<void> unlikePost(String userId, String postId) async {
    await (_database.delete(_database.likes)..where(
          (row) => row.userId.equals(userId) & row.postId.equals(postId),
        ))
        .go();
  }

  Future<List<FollowModel>> getFollowers(String userId) async {
    final rows = await (_database.select(
      _database.follows,
    )..where((row) => row.followingId.equals(userId))).get();
    return rows.map(_followModel).toList();
  }

  Future<List<FollowModel>> getFollowing(String userId) async {
    final rows = await (_database.select(
      _database.follows,
    )..where((row) => row.followerId.equals(userId))).get();
    return rows.map(_followModel).toList();
  }

  Future<void> followUser(FollowModel model) async {
    await _database
        .into(_database.follows)
        .insertOnConflictUpdate(
          FollowsCompanion.insert(
            followerId: model.followerId,
            followingId: model.followingId,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> cacheFollow(FollowModel model) => followUser(model);

  Future<void> unfollowUser(String followerId, String followingId) async {
    await (_database.delete(_database.follows)..where(
          (row) =>
              row.followerId.equals(followerId) &
              row.followingId.equals(followingId),
        ))
        .go();
  }

  Future<List<StoryModel>> getUserStories(String userId) async {
    final rows =
        await (_database.select(_database.stories)
              ..where(
                (row) =>
                    row.userId.equals(userId) &
                    row.expiresAt.isBiggerThanValue(DateTime.now()),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
    return rows.map(_storyModel).toList();
  }

  Future<void> createStory(StoryModel model) async => cacheStory(model);

  Future<void> cacheStory(StoryModel model) async {
    await _database
        .into(_database.stories)
        .insertOnConflictUpdate(
          StoriesCompanion.insert(
            id: model.id,
            userId: model.userId,
            mediaUrl: model.mediaUrl,
            mediaType: model.mediaType,
            createdAt: model.createdAt,
            expiresAt: model.expiresAt,
          ),
        );
  }

  Future<void> deleteStory(String storyId) async {
    await (_database.delete(
      _database.stories,
    )..where((row) => row.id.equals(storyId))).go();
  }

  Future<bool> hasViewedStory(String storyId, String userId) async {
    final row =
        await (_database.select(_database.storyViews)..where(
              (view) =>
                  view.storyId.equals(storyId) & view.userId.equals(userId),
            ))
            .getSingleOrNull();
    return row != null;
  }

  Future<void> addStoryView(StoryViewModel model) async {
    await _database
        .into(_database.storyViews)
        .insertOnConflictUpdate(
          StoryViewsCompanion.insert(
            userId: model.userId,
            storyId: model.storyId,
            viewedAt: model.viewedAt,
          ),
        );
  }

  Future<void> cacheStoryView(StoryViewModel model) => addStoryView(model);

  Future<List<ConversationModel>> getUserConversations(String userId) async {
    final memberships = await (_database.select(
      _database.conversationMembers,
    )..where((row) => row.userId.equals(userId))).get();
    final ids = memberships.map((row) => row.conversationId).toSet();
    if (ids.isEmpty) return [];
    final rows = await (_database.select(
      _database.conversations,
    )..where((row) => row.id.isIn(ids))).get();
    return rows.map(_conversationModel).toList();
  }

  Future<List<ConversationMemberModel>> getConversationMembers(
    String conversationId,
  ) async {
    final rows = await (_database.select(
      _database.conversationMembers,
    )..where((row) => row.conversationId.equals(conversationId))).get();
    return rows
        .map(
          (row) => ConversationMemberModel(
            conversationId: row.conversationId,
            userId: row.userId,
          ),
        )
        .toList();
  }

  Future<void> createConversation(ConversationModel model) async {
    await _database
        .into(_database.conversations)
        .insertOnConflictUpdate(
          ConversationsCompanion.insert(
            id: model.id,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> cacheConversation(ConversationModel model) async =>
      createConversation(model);

  Future<void> addConversationMember(ConversationMemberModel model) async {
    await _database
        .into(_database.conversationMembers)
        .insertOnConflictUpdate(
          ConversationMembersCompanion.insert(
            userId: model.userId,
            conversationId: model.conversationId,
          ),
        );
  }

  Future<void> cacheConversationMember(ConversationMemberModel model) =>
      addConversationMember(model);

  Future<List<MessageModel>> getMessages(String conversationId) async {
    final rows =
        await (_database.select(_database.messages)
              ..where((row) => row.conversationId.equals(conversationId))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
    return rows.map(_messageModel).toList();
  }

  Future<List<MessageModel>> getConversationMessages(String conversationId) =>
      getMessages(conversationId);

  Future<void> sendMessage(MessageModel model) async => cacheMessage(model);

  Future<void> cacheMessage(MessageModel model) async {
    await _database
        .into(_database.messages)
        .insertOnConflictUpdate(
          MessagesCompanion.insert(
            id: model.id,
            conversationId: model.conversationId,
            senderId: model.senderId,
            textContent: model.text,
            createdAt: model.createdAt,
          ),
        );
  }

  Future<void> deleteMessage(String messageId) async {
    await (_database.delete(
      _database.messages,
    )..where((row) => row.id.equals(messageId))).go();
  }

  UserModel _userModel(User row) => UserModel(
    id: row.id,
    username: row.username,
    name: row.name,
    avatarUrl: row.avatarUrl,
    bio: row.bio,
    createdAt: row.createdAt,
  );

  PostModel _postModel(Post row) => PostModel(
    id: row.id,
    userId: row.userId,
    caption: row.caption,
    createdAt: row.createdAt,
  );

  PostMediaModel _postMediaModel(PostMediaData row) => PostMediaModel(
    id: row.id,
    postId: row.postId,
    mediaUrl: row.mediaUrl,
    mediaType: row.mediaType,
    position: row.position,
  );

  CommentModel _commentModel(Comment row) => CommentModel(
    id: row.id,
    postId: row.postId,
    userId: row.userId,
    text: row.textContent,
    createdAt: row.createdAt,
  );

  LikeModel _likeModel(Like row) => LikeModel(
    id: row.id,
    postId: row.postId,
    userId: row.userId,
    createdAt: row.createdAt,
  );

  FollowModel _followModel(Follow row) => FollowModel(
    followerId: row.followerId,
    followingId: row.followingId,
    createdAt: row.createdAt,
  );

  StoryModel _storyModel(Story row) => StoryModel(
    id: row.id,
    userId: row.userId,
    mediaUrl: row.mediaUrl,
    mediaType: row.mediaType,
    createdAt: row.createdAt,
    expiresAt: row.expiresAt,
  );

  ConversationModel _conversationModel(Conversation row) => ConversationModel(
    id: row.id,
    createdAt: row.createdAt,
  );

  MessageModel _messageModel(Message row) => MessageModel(
    id: row.id,
    conversationId: row.conversationId,
    senderId: row.senderId,
    text: row.textContent,
    createdAt: row.createdAt,
  );
}
