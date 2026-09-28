import 'package:instagram_clone/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    await tokenStorage.saveTokens(
      accessToken: auth.accessToken,
      refreshToken: auth.refreshToken,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUserId', auth.userId);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getBool('isLoggedIn') ?? false;
}

Future<void> logout() async {
  
  final prefs = await SharedPreferences.getInstance();

  try {
    await remoteDataSource.logout();
  } finally {
    await tokenStorage.clearTokens();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUserId');
  }
}

  Future<AuthModel> signup(String email, String password) async {
    final auth = await remoteDataSource.signup(email, password);

    if (auth.refreshToken != null) {
      await tokenStorage.saveTokens(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
      );
    }

    return auth;
  }
}
