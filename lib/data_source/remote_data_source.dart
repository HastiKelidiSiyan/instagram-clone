import 'package:dio/dio.dart';
import 'package:instagram_clone/models/post_model.dart';

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
}
