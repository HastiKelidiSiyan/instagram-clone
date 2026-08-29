import 'package:drift/drift.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/models/post_model.dart';

class LocalDataSource {
  final database = AppDatabase();

  Future<List<PostModel>> getPosts() async {
    try {
      final posts = await database.select(database.posts).get();
      List<PostModel> postModels = [];
      for (var post in posts) {
        final user = await getUserById(post.userId);
        final likedBy = await getUserById(post.likedByUserId);
        postModels = posts.map((post) {
          return PostModel(
            user: user,
            subtitle: post.subtitle,
            postImage: post.postImage,
            caption: post.caption,
            likedBy: likedBy,
            totalLikes: post.totalLikes,
            totalComments: post.totalComments,
          );
        }).toList();
      }
      return postModels;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<void> cachePosts(List<PostModel> posts) async {
    try {
      for (var post in posts) {
        final user = await getUserById(post.user.userId);
        final likedByuser = await getUserById(post.likedBy!.userId);
        await database.into(database.posts).insert(
          PostsCompanion.insert(
            userId: user.userId,
            subtitle: post.subtitle,
            postImage: post.postImage,
            caption: post.caption,
            likedByUserId: likedByuser.userId,
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
      List<StoryModel> storyModels = [];
      for (var story in stories) {
        final user = await getUserById(story.userId);
        storyModels = stories.map((story) {
          return StoryModel(
            user: user,
            seen: story.seen,
          );
        }).toList();
      }
      return storyModels;
    } catch (e) {
      throw Exception('Failed to get stories: $e');
    }
  }

  Future<void> cacheStories(List<StoryModel> stories) async {
    try {
      for (var story in stories) {
        final user = await getUserById(story.user.userId);
        await database.into(database.stories).insert(
          StoriesCompanion.insert(
            userId: user.userId,
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
      List<MessageModel> messageModels = [];
      for (var message in messages) {
        final user = await getUserById(message.userId);
        messageModels = messages.map((message) {
          return MessageModel(
            user: user,
            lastMessage: message.lastMessage,
            date: message.date,
          );
        }).toList();
      }
      return messageModels;
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  Future<void> cacheMessages(List<MessageModel> messages) async {
    try {
      for (var message in messages) {
        final user = await getUserById(message.user.userId);
        await database.into(database.messages).insert(
          MessagesCompanion.insert(
            userId: user.userId,
            lastMessage: message.lastMessage,
            date: message.date,
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
              userId: user.id,
              name: user.name,
              username: user.username,
              avatar: user.avatar,
              totalPosts: user.totalPosts,
              totalFollowers: user.totalFollowers,
              totalFollowings: user.totalFollowings,
              bio: user.bio,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }

  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      for (var user in users) {
        await database.into(database.users).insert(
          UsersCompanion.insert(
            id: user.userId,
            name: user.name,
            username: user.username,
            avatar: user.avatar,
            totalPosts: Value(user.totalPosts),
            totalFollowers: Value(user.totalFollowers),
            totalFollowings: Value(user.totalFollowings),
            bio: user.bio,
          ),
        );
      }
    } catch (e) {
      throw Exception('Failed to cache users: $e');
    }
  }

  Future<UserModel> getUserById(int id) async {
    try {
      final user = await (database.select(
        database.users,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
      if (user == null) {
        throw Exception('User not found');
      }
      return UserModel(
        userId: user.id,
        name: user.name,
        username: user.username,
        avatar: user.avatar,
        totalPosts: user.totalPosts,
        totalFollowers: user.totalFollowers,
        totalFollowings: user.totalFollowings,
        bio: user.bio,
      );
    } catch (e) {
      throw Exception('Failed to get user by id: $e');
    }
  }
}
