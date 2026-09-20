import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class UserRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<UserModel>> getUsers([String query = '']) async {
    if (await connectivityResult.isConnected()) {
      final users = await remoteDataSource.searchUsers(query);
      return users;
    }

    return localDataSource.searchUsers(query);
  }

  Future<UserModel> getUserById(dynamic userId) async {
    final id = userId.toString();

    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getUser(id);
    }

    return localDataSource.getUser(id);
  }

  Future<bool> addUser(UserModel user) async {
    if (await connectivityResult.isConnected()) {
      remoteDataSource.addUser(user);
      return true;
    }
    return false;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final users = await getUsers(username);
    if (users.isEmpty) {
      return null;
    }

    return users.first;
  }

  Future<UserModel> getMe() async {
    final users = await getUserByUsername('hasti_kelidi');


    return UserModel(
      id: 'me',
      name: 'Current User',
      username: 'current_user',
      avatarUrl: null,
      bio: null,
      createdAt: DateTime.now(),
    );
  }
}
