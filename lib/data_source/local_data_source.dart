import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/models/post_model.dart';

class LocalDataSource {
  final AppDatabase database;

  LocalDataSource([AppDatabase? database])
    : database = database ?? AppDatabase.instance;

  Future<void> cacheMe(UserModel user) async {
    try {
      await database
          .into(database.users)
          .insertOnConflictUpdate(
            UsersCompanion.insert(
              name: user.name,
              username: user.username,
              avatar: user.avatar,
              totalPosts: user.totalPosts,
              totalFollowers: user.totalFollowers,
              totalFollowings: user.totalFollowings,
              bio: user.bio,
            ),
          );
    } catch (e) {
      throw Exception('Failed to cache user: $e');
    }
  }

  Future<UserModel> getMe() async {
    try {
      final users = await database.select(database.users).get();
      return UserModel(
        userId: users.first.userId,
        name: users.first.name,
        username: users.first.username,
        avatar: users.first.avatar,
        bio: users.first.bio,
      );
    } catch (e) {
      throw Exception('Failed to find the user: $e');
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      final posts = await database.select(database.posts).get();
      return posts
          .map(
            (post) => PostModel(
              user: _userFromJson(post.userJson),
              subtitle: post.subtitle,
              postImage: post.postImage,
              caption: post.caption,
              likedBy: post.likedByJson == null
                  ? null
                  : _userFromJson(post.likedByJson!),
              totalLikes: post.totalLikes,
              totalComments: post.totalComments,
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
                userId: Value(post.user.userId),
                userJson: jsonEncode(post.user.toJson()),
                subtitle: post.subtitle,
                postImage: post.postImage,
                caption: post.caption,
                likedByJson: Value(
                  post.likedBy == null
                      ? null
                      : jsonEncode(post.likedBy!.toJson()),
                ),
                totalLikes: Value(post.totalLikes),
                totalComments: Value(post.totalComments),
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
              user: _userFromJson(story.userJson),
              seen: story.seen,
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
                userId: Value(story.user.userId),
                userJson: jsonEncode(story.user.toJson()),
                seen: Value(story.seen),
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
              user: _userFromJson(message.userJson),
              lastMessage: message.lastMessage,
              date: message.date,
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
                userId: Value(message.user.userId),
                userJson: jsonEncode(message.user.toJson()),
                lastMessage: message.lastMessage,
                date: message.date,
              ),
            );
      }
    } catch (e) {
      throw Exception('Failed to cache messages: $e');
    }
  }

  UserModel _userFromJson(String userJson) {
    return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final posts = await getPosts();
      final stories = await getStories();
      final messages = await getMessages();
      final users = <int, UserModel>{};

      for (final post in posts) {
        users[post.user.userId] = post.user;
        if (post.likedBy != null) {
          users[post.likedBy!.userId] = post.likedBy!;
        }
      }
      for (final story in stories) {
        users[story.user.userId] = story.user;
      }
      for (final message in messages) {
        users[message.user.userId] = message.user;
      }

      return users.values.toList();
    } catch (e) {
      throw Exception('Failed to get cached users: $e');
    }
  }

  Future<UserModel?> getUserById(int id) async {
    final users = await getUsers();
    for (final user in users) {
      if (user.userId == id) {
        return user;
      }
    }
    return null;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final users = await getUsers();
    for (final user in users) {
      if (user.username == username) {
        return user;
      }
    }
    return null;
  }
}
