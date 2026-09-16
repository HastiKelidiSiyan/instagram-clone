import '../core/storage/secure_token_storage.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource =
      AuthRemoteDataSource();

  final SecureTokenStorage tokenStorage =
      SecureTokenStorage();

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
  }

  Future<void> logout() async {
  await remoteDataSource.logout();
  await tokenStorage.clearTokens();
}

  Future<bool> isLoggedIn() async {
    final accessToken = await tokenStorage.getAccessToken();

    return accessToken != null;
  }
}