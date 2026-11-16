import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/domain/profile_data.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/auth_repository.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class UserRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  // final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();
  final AuthRepository authRepository = AuthRepository();

  Future<List<UserModel>> searchUsers(String query) async {
    if (await connectivityResult.isConnected()) {
      final users = await remoteDataSource.searchUsers(query);
      return users;
    }
    return [];
    // return localDataSource.searchUsers(query);
  }

  Future<UserModel?> getUser(String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getUser(userId);
    }

    return null;
    // return localDataSource.getUser(id);
  }

  Future<ProfileData?> getProfileData(String userId) async {
    if (await connectivityResult.isConnected()) {
      final currentUserId = await authRepository.getCurrentUserId();

      if (currentUserId == null) {
        throw const UnauthorizedFailure();
      }

      return remoteDataSource.getProfileData(userId, currentUserId);
    }

    return null;
  }

  Future<bool> addUser(UserModel user) async {
    if (await connectivityResult.isConnected()) {
      remoteDataSource.addUser(user);
      return true;
    }

    return false;
  }
}
