import 'package:dio/dio.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class RemoteDataSource {
  final dio = Dio();

  static const String usersAndStoriesBaseUrl =
      'https://695438ec1cd5294d2c7c33d5.mockapi.io';
  static const String postsAndMessagesBaseUrl =
      'https://69543dae1cd5294d2c7c3e3a.mockapi.io';
  static const String currentUserBaseUrl =
      'https://695458e61cd5294d2c7c7147.mockapi.io';

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dio.get('$postsAndMessagesBaseUrl/posts');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<MessageModel>> getMessages() async {
    try {
      final response = await dio.get('$postsAndMessagesBaseUrl/messages');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => MessageModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<StoryModel>> getStories() async {
    try {
      final response = await dio.get('$usersAndStoriesBaseUrl/stories');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => StoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load stories');
      }
    } catch (e) {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dio.get('$usersAndStoriesBaseUrl/users');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => UserModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      final response = await dio.get(
        '$usersAndStoriesBaseUrl/users',
        queryParameters: {'userId': id},
      );
      if (response.statusCode == 200) {
        final users = response.data as List;
        if (users.isEmpty) {
          return null;
        }
        return UserModel.fromJson(users.first as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final response = await dio.get(
        '$usersAndStoriesBaseUrl/users',
        queryParameters: {'username': username},
      );
      if (response.statusCode == 200) {
        final users = response.data as List;
        if (users.isEmpty) {
          return null;
        }
        return UserModel.fromJson(users.first as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel?> addUser(UserModel user) async {
    try {
      final response = await dio.post(
        '$usersAndStoriesBaseUrl/users',
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }
}
