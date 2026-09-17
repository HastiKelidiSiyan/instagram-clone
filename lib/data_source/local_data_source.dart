import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_members_model.dart';
import 'package:instagram_clone/models/follows_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class LocalDataSource {
  final AppDatabase database;

  LocalDataSource([AppDatabase? database])
    : database = database ?? AppDatabase.instance;

  Future<List<PostModel>> getPosts() async {
    try {
      final posts = await database.select(database.posts).get();
      return posts
          .map(
            (post) => PostModel(
              id: post.id,
              userId: post.userId,
              caption: post.caption,
              createdAt: post.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<void> cachePosts(List<PostModel> posts) async {
    try {
      for (var post in posts) {
        await database
            .into(database.posts)
            .insertOnConflictUpdate(
              PostsCompanion.insert(
                id: Value(post.id),
                userId: post.userId,
                caption: post.caption,
                createdAt: post.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache posts: $e');
    }
  }

  Future<List<StoryModel>> getStories() async {
    try {
      final stories = await database.select(database.stories).get();
      return stories
          .map(
            (story) => StoryModel(
              id: story.id,
              userId: story.userId,
              mediaUrl: story.mediaUrl,
              mediaType: story.mediaType,
              createdAt: story.createdAt,
              expiresAt: story.expiresAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get stories: $e');
    }
  }

  Future<void> cacheStories(List<StoryModel> stories) async {
    try {
      for (var story in stories) {
        await database
            .into(database.stories)
            .insertOnConflictUpdate(
              StoriesCompanion.insert(
                id: Value(story.id),
                userId: story.userId,
                mediaUrl: story.mediaUrl,
                mediaType: story.mediaType,
                createdAt: story.createdAt,
                expiresAt: story.expiresAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache stories: $e');
    }
  }

  Future<List<MessageModel>> getMessages() async {
    try {
      final messages = await database.select(database.messages).get();
      return messages
          .map(
            (message) => MessageModel(
              id: message.id,
              conversationId: message.conversationId,
              senderId: message.senderId,
              text: message.textContent,
              createdAt: message.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  Future<void> cacheMessages(List<MessageModel> messages) async {
    try {
      for (var message in messages) {
        await database
            .into(database.messages)
            .insertOnConflictUpdate(
              MessagesCompanion.insert(
                id: Value(message.id),
                conversationId: message.conversationId,
                senderId: message.senderId,
                textContent: message.text,
                createdAt: message.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache messages: $e');
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final users = await database.select(database.users).get();
      return users
          .map(
            (user) => UserModel(
              id: user.id,
              name: user.name,
              username: user.username,
              avatarUrl: user.avatarUrl,
              bio: user.bio,
              createdAt: user.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      for (var user in users) {
        await database
            .into(database.users)
            .insertOnConflictUpdate(
              UsersCompanion(
                id: Value(user.id),
                username: Value(user.username),
                name: Value(user.name),
                avatarUrl: Value(user.avatarUrl),
                bio: Value(user.bio),
                createdAt: Value(user.createdAt),
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache users: $e');
    }
  }

  Future<List<StoryViewModel>> getStoryViews() async {
    try {
      final storyViews = await database.select(database.storyViews).get();
      return storyViews
          .map(
            (storyView) => StoryViewModel(
              userId: storyView.userId,
              storyId: storyView.storyId,
              viewedAt: storyView.viewdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get story views: $e');
    }
  }

  Future<void> cacheStoryViews(List<StoryViewModel> storyViews) async {
    try {
      for (var storyView in storyViews) {
        await database
            .into(database.storyViews)
            .insertOnConflictUpdate(
              StoryViewsCompanion.insert(
                userId: storyView.userId,
                storyId: storyView.storyId,
                viewdAt: storyView.viewedAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache story views: $e');
    }
  }

  Future<List<PostMediaModel>> getPostMedia() async {
    try {
      final postMedia = await database.select(database.postMedia).get();
      return postMedia
          .map(
            (media) => PostMediaModel(
              id: media.id,
              postId: media.postId,
              mediaUrl: media.mediaUrl,
              mediaType: media.mediaType,
              position: media.position,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get post media: $e');
    }
  }

  Future<void> cachePostMedia(List<PostMediaModel> postMedia) async {
    try {
      for (var media in postMedia) {
        await database
            .into(database.postMedia)
            .insertOnConflictUpdate(
              PostMediaCompanion.insert(
                id: Value(media.id),
                postId: media.postId,
                mediaUrl: media.mediaUrl,
                mediaType: media.mediaType,
                position: media.position,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache post media: $e');
    }
  }

  Future<List<LikeModel>> getLikes() async {
    try {
      final likes = await database.select(database.likes).get();
      return likes
          .map(
            (like) => LikeModel(
              id: like.id,
              userId: like.userId,
              postId: like.postId,
              createdAt: like.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get likes: $e');
    }
  }

  Future<void> cacheLikes(List<LikeModel> likes) async {
    try {
      for (var like in likes) {
        await database
            .into(database.likes)
            .insertOnConflictUpdate(
              LikesCompanion.insert(
                id: like.id,
                userId: like.userId,
                postId: like.postId,
                createdAt: like.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache likes: $e');
    }
  }

  Future<List<CommentsModel>> getComments() async {
    try {
      final comments = await database.select(database.comments).get();
      return comments
          .map(
            (comment) => CommentsModel(
              id: comment.id,
              postId: comment.postId,
              userId: comment.userId,
              text: comment.textContent,
              createdAt: comment.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get comments: $e');
    }
  }

  Future<void> cacheComments(List<CommentsModel> comments) async {
    try {
      for (var comment in comments) {
        await database
            .into(database.comments)
            .insertOnConflictUpdate(
              CommentsCompanion.insert(
                id: Value(comment.id),
                postId: comment.postId,
                userId: comment.userId,
                textContent: comment.text,
                createdAt: comment.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache comments: $e');
    }
  }

  Future<List<ConversationModel>> getConversations() async {
    try {
      final conversations = await database.select(database.conversations).get();
      return conversations
          .map(
            (conversation) => ConversationModel(
              id: conversation.id,
              createdAt: conversation.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<void> cacheConversations(List<ConversationModel> conversations) async {
    try {
      for (var conversation in conversations) {
        await database
            .into(database.conversations)
            .insertOnConflictUpdate(
              ConversationsCompanion.insert(
                id: Value(conversation.id),
                createdAt: conversation.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache conversations: $e');
    }
  }

  Future<List<ConverstionMembersModel>> getConversationMembers() async {
    try {
      final members = await database.select(database.conversationMembers).get();
      return members
          .map(
            (member) => ConverstionMembersModel(
              conversationId: member.conversationId,
              userId: member.userId,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get conversation members: $e');
    }
  }

  Future<void> cacheConversationMembers(
    List<ConverstionMembersModel> conversationMembers,
  ) async {
    try {
      for (var member in conversationMembers) {
        await database
            .into(database.conversationMembers)
            .insertOnConflictUpdate(
              ConversationMembersCompanion.insert(
                userId: member.userId,
                conversationId: member.conversationId,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache conversation members: $e');
    }
  }

  Future<List<FollowsModel>> getFollows() async {
    try {
      final follows = await database.select(database.follows).get();
      return follows
          .map(
            (follow) => FollowsModel(
              follwerId: follow.followerId,
              followingId: follow.followingId,
              createdAt: follow.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get follows: $e');
    }
  }

  Future<void> cacheFollows(List<FollowsModel> follows) async {
    try {
      for (var follow in follows) {
        await database
            .into(database.follows)
            .insertOnConflictUpdate(
              FollowsCompanion.insert(
                followerId: follow.follwerId,
                followingId: follow.followingId,
                createdAt: follow.createdAt,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache follows: $e');
    }
  }
}
