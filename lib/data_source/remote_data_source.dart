import 'package:dio/dio.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';

class RemoteDataSource {
  final Dio _dio;

  RemoteDataSource()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => print('[Dio] $log'),
      ),
    );
  }

  static const String usersAndStoriesBaseUrl =
      'https://695438ec1cd5294d2c7c33d5.mockapi.io';
  static const String postsAndMessagesBaseUrl =
      'https://69543dae1cd5294d2c7c3e3a.mockapi.io';
  static const String currentUserBaseUrl =
      'https://695458e61cd5294d2c7c7147.mockapi.io';

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dio.get('$postsAndMessagesBaseUrl/posts');
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
      final response = await _dio.get('$usersAndStoriesBaseUrl/users');
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
      final response = await _dio.get(
        '$usersAndStoriesBaseUrl/users',
        queryParameters: {'userId': id},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data[0]);
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
        '$usersAndStoriesBaseUrl/users',
        queryParameters: {'username': username},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data[0]);
      } else {
        throw Exception('${response.statusCode}: Failed to load user');
      }
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<UserModel?> addUser(UserModel user) async {
    try {
      final response = await _dio.post(
        '$usersAndStoriesBaseUrl/users',
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('${response.statusCode}: Failed to add user');
      }
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
