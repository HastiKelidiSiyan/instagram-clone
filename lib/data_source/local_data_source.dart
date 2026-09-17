import 'package:drift/drift.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/follow_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';

class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource([AppDatabase? database])
    : _database = database ?? AppDatabase.instance;

  Future<UserModel> getUser(String userId) async {
    final user = await (_database.select(_database.users)
          ..where((table) => table.id.equals(userId)))
        .getSingle();

    return UserModel.fromJson(user.toJson());
  }

  Future<List<UserModel>> searchUsers(String query) async {
    final users = await (_database.select(_database.users)
          ..where((table) => table.username.like('%$query%')))
        .get();

    return users
        .map((user) => UserModel.fromJson(user.toJson()))
        .toList();
  }

  Future<void> updateUser(
    String userId,
    Map<String, dynamic> data,
  ) async {
    await (_database.update(_database.users)
          ..where((table) => table.id.equals(userId)))
        .write(
      UsersCompanion(
        username: data['username'] != null
            ? Value(data['username'])
            : const Value.absent(),
        name: data['name'] != null
            ? Value(data['name'])
            : const Value.absent(),
        avatarUrl: data['avatar_url'] != null
            ? Value(data['avatar_url'])
            : const Value.absent(),
        bio: data['bio'] != null
            ? Value(data['bio'])
            : const Value.absent(),
      ),
    );
  }

  // =========================
  // POSTS
  // =========================

  Future<List<PostModel>> getPosts() async {
    final posts = await (_database.select(_database.posts)
          ..orderBy([
            (table) => OrderingTerm.desc(table.createdAt),
          ]))
        .get();

    return posts
        .map((post) => PostModel.fromJson(post.toJson()))
        .toList();
  }

  Future<List<PostModel>> getUserPosts(String userId) async {
    final posts = await (_database.select(_database.posts)
          ..where((table) => table.userId.equals(userId))
          ..orderBy([
            (table) => OrderingTerm.desc(table.createdAt),
          ]))
        .get();

    return posts
        .map((post) => PostModel.fromJson(post.toJson()))
        .toList();
  }

  Future<PostModel> getPost(String postId) async {
    final post = await (_database.select(_database.posts)
          ..where((table) => table.id.equals(postId)))
        .getSingle();

    return PostModel.fromJson(post.toJson());
  }

  Future<void> createPost(PostModel post) async {
    await _database.into(_database.posts).insert(
          PostsCompanion.insert(
            id: post.id,
            userId: post.userId,
            caption: post.caption,
            createdAt: post.createdAt,
          ),
        );
  }

  Future<void> deletePost(String postId) async {
    await (_database.delete(_database.posts)
          ..where((table) => table.id.equals(postId)))
        .go();
  }

  // =========================
  // POST MEDIA
  // =========================

  Future<List<PostMediaModel>> getPostMedia(String postId) async {
    final media = await (_database.select(_database.postMedia)
          ..where((table) => table.postId.equals(postId))
          ..orderBy([
            (table) => OrderingTerm.asc(table.position),
          ]))
        .get();

    return media
        .map((item) => PostMediaModel.fromJson(item.toJson()))
        .toList();
  }

  Future<void> createPostMedia(PostMediaModel media) async {
    await _database.into(_database.postMedia).insert(
          PostMediaCompanion.insert(
            id: media.id,
            postId: media.postId,
            mediaUrl: media.mediaUrl,
            mediaType: media.mediaType,
            position: media.position,
          ),
        );
  }

  Future<void> deletePostMedia(String mediaId) async {
    await (_database.delete(_database.postMedia)
          ..where((table) => table.id.equals(mediaId)))
        .go();
  }

  // =========================
  // COMMENTS
  // =========================

  Future<List<CommentModel>> getComments(String postId) async {
    final comments = await (_database.select(_database.comments)
          ..where((table) => table.postId.equals(postId))
          ..orderBy([
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .get();

    return comments
        .map((comment) => CommentModel.fromJson(comment.toJson()))
        .toList();
  }

  Future<void> createComment(CommentModel comment) async {
    await _database.into(_database.comments).insert(
          CommentsCompanion.insert(
            id: comment.id,
            postId: comment.postId,
            userId: comment.userId,
            textContent: comment.text,
            createdAt: comment.createdAt,
          ),
        );
  }

  Future<void> deleteComment(String commentId) async {
    await (_database.delete(_database.comments)
          ..where((table) => table.id.equals(commentId)))
        .go();
  }

  // =========================
  // LIKES
  // =========================

  Future<bool> isPostLiked(
    String userId,
    String postId,
  ) async {
    final like = await (_database.select(_database.likes)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.postId.equals(postId),
          ))
        .get();

    return like.isNotEmpty;
  }

  Future<void> likePost(LikeModel like) async {
    await _database.into(_database.likes).insert(
          LikesCompanion.insert(
            id: like.id,
            userId: like.userId,
            postId: like.postId,
            createdAt: like.createdAt,
          ),
        );
  }

  Future<void> unlikePost(
    String userId,
    String postId,
  ) async {
    await (_database.delete(_database.likes)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.postId.equals(postId),
          ))
        .go();
  }

  // =========================
  // FOLLOWS
  // =========================

  Future<List<FollowModel>> getFollowers(String userId) async {
    final follows = await (_database.select(_database.follows)
          ..where((table) => table.followingId.equals(userId)))
        .get();

    return follows
        .map((follow) => FollowModel.fromJson(follow.toJson()))
        .toList();
  }

  Future<List<FollowModel>> getFollowing(String userId) async {
    final follows = await (_database.select(_database.follows)
          ..where((table) => table.followerId.equals(userId)))
        .get();

    return follows
        .map((follow) => FollowModel.fromJson(follow.toJson()))
        .toList();
  }

  Future<void> followUser(FollowModel follow) async {
    await _database.into(_database.follows).insert(
          FollowsCompanion.insert(
            followerId: follow.followerId,
            followingId: follow.followingId,
            createdAt: follow.createdAt,
          ),
        );
  }

  Future<void> unfollowUser(
    String followerId,
    String followingId,
  ) async {
    await (_database.delete(_database.follows)
          ..where(
            (table) =>
                table.followerId.equals(followerId) &
                table.followingId.equals(followingId),
          ))
        .go();
  }

  // =========================
  // STORIES
  // =========================

  Future<List<StoryModel>> getActiveStories() async {
    final now = DateTime.now();

    final stories = await (_database.select(_database.stories)
          ..where((table) => table.expiresAt.isBiggerThanValue(now))
          ..orderBy([
            (table) => OrderingTerm.desc(table.createdAt),
          ]))
        .get();

    return stories
        .map((story) => StoryModel.fromJson(story.toJson()))
        .toList();
  }

  Future<List<StoryModel>> getUserStories(String userId) async {
    final now = DateTime.now();

    final stories = await (_database.select(_database.stories)
          ..where(
            (table) =>
                table.userId.equals(userId) &
                table.expiresAt.isBiggerThanValue(now),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .get();

    return stories
        .map((story) => StoryModel.fromJson(story.toJson()))
        .toList();
  }

  Future<void> createStory(StoryModel story) async {
    await _database.into(_database.stories).insert(
          StoriesCompanion.insert(
            id: story.id,
            userId: story.userId,
            mediaUrl: story.mediaUrl,
            mediaType: story.mediaType,
            createdAt: story.createdAt,
            expiresAt: story.expiresAt,
          ),
        );
  }

  Future<void> deleteStory(String storyId) async {
    await (_database.delete(_database.stories)
          ..where((table) => table.id.equals(storyId)))
        .go();
  }

  // =========================
  // STORY VIEWS
  // =========================

  Future<bool> hasViewedStory(
    String storyId,
    String userId,
  ) async {
    final views = await (_database.select(_database.storyViews)
          ..where(
            (table) =>
                table.storyId.equals(storyId) &
                table.userId.equals(userId),
          ))
        .get();

    return views.isNotEmpty;
  }

  Future<void> addStoryView(StoryViewModel view) async {
    await _database.into(_database.storyViews).insert(
          StoryViewsCompanion.insert(
            storyId: view.storyId,
            userId: view.userId,
            viewedAt: view.viewedAt,
          ),
        );
  }

  // =========================
  // CONVERSATIONS
  // =========================

Future<List<ConversationModel>> getUserConversations(
  String userId,
) async {
  final memberships = await (_database.select(
    _database.conversationMembers,
  )..where((table) => table.userId.equals(userId)))
      .get();

  final conversations = <ConversationModel>[];

  for (final membership in memberships) {
    final conversation = await (_database.select(
      _database.conversations,
    )..where(
        (table) => table.id.equals(membership.conversationId),
      ))
        .getSingle();

    conversations.add(
      ConversationModel.fromJson(conversation.toJson()),
    );
  }

  return conversations;
}

Future<List<ConversationMemberModel>> getConversationMembers(
  String conversationId,
) async {
  final members = await (_database.select(
    _database.conversationMembers,
  )..where(
      (table) => table.conversationId.equals(conversationId),
    ))
      .get();

  return members
      .map(
        (member) => ConversationMemberModel.fromJson(
          member.toJson(),
        ),
      )
      .toList();
}

Future<void> createConversation(
  ConversationModel conversation,
) async {
  await _database.into(_database.conversations).insert(
        ConversationsCompanion.insert(
          id: conversation.id,
          createdAt: conversation.createdAt,
        ),
      );
}

Future<void> addConversationMember(
  ConversationMemberModel member,
) async {
  await _database.into(_database.conversationMembers).insert(
        ConversationMembersCompanion.insert(
          conversationId: member.conversationId,
          userId: member.userId,
        ),
      );
}


  // =========================
  // MESSAGES
  // =========================

  Future<List<MessageModel>> getMessages(
    String conversationId,
  ) async {
    final messages = await (_database.select(_database.messages)
          ..where(
            (table) => table.conversationId.equals(conversationId),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .get();

    return messages
        .map((message) => MessageModel.fromJson(message.toJson()))
        .toList();
  }

  Future<void> sendMessage(MessageModel message) async {
    await _database.into(_database.messages).insert(
          MessagesCompanion.insert(
            id: message.id,
            conversationId: message.conversationId,
            senderId: message.senderId,
            textContent: message.text,
            createdAt: message.createdAt,
          ),
        );
  }

  Future<void> deleteMessage(String messageId) async {
    await (_database.delete(_database.messages)
          ..where((table) => table.id.equals(messageId)))
        .go();
  }
}
