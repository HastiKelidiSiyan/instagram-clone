import 'package:instagram_clone/models/auth_model.dart';

import '../core/storage/secure_token_storage.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource();

  final SecureTokenStorage tokenStorage = SecureTokenStorage();

  Future<void> login(
    String email,
    String password,
  ) async {
    final auth = await remoteDataSource.login(
      email,
      password,
    );

    await tokenStorage.saveSession(
      accessToken: auth.accessToken,
      refreshToken: auth.refreshToken,
      userId: auth.userId,
    );
  }

  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } finally {
      await tokenStorage.clearSession();
    }
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await tokenStorage.getAccessToken();
    final refreshToken = await tokenStorage.getRefreshToken();
    final userId = await tokenStorage.getUserId();

    return accessToken != null && refreshToken != null && userId != null;
  }

  Future<String?> getCurrentUserId() {
    return tokenStorage.getUserId();
  }

  Future<AuthModel> signup(String email, String password) async {
    final auth = await remoteDataSource.signup(email, password);

    if (auth.accessToken != null && auth.refreshToken != null) {
      await tokenStorage.saveSession(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
        userId: auth.userId,
      );
    }

    return auth;
  }
}
