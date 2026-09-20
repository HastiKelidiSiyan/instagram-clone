import 'package:dio/dio.dart';

import '../core/network/dio_client.dart';
import '../models/auth_model.dart';

class AuthRemoteDataSource {
  final Dio dio = DioClient.dio;

  Future<AuthModel> login(
    String email,
    String password,
  ) async {
    final response = await dio.post(
      '/auth/v1/token?grant_type=password',
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthModel.fromJson(response.data);
  }

  Future<void> logout() async {
    await dio.post('/auth/v1/logout');
  }

  Future<AuthModel> signup(String email, String password) async {
    final response = await dio.post(
      '/auth/v1/signup',
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthModel.fromJson(response.data);
  }
}
