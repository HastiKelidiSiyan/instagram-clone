import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';
import '../models/user_model.dart';

class UserRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalDataSource localDataSource = LocalDataSource();
  ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<UserModel>> getUsers() async {
    if (await connectivityResult.isConnected()) {
      final users = await remoteDataSource.getUsers();
      return users;
    } else {
      return await localDataSource.getUsers();
    }
  }

  Future<UserModel?> getUserById(int id) async {
    if (await connectivityResult.isConnected()) {
      final user = await remoteDataSource.getUserById(id);
      return user;
    } else {
      return await localDataSource.getUserById(id);
    }
  }

  Future<UserModel?> addUser(UserModel user) async {
    return await remoteDataSource.addUser(user);
  }

  Future<UserModel?> getUserByUsername(String username) async {
    if (await connectivityResult.isConnected()) {
      final user = await remoteDataSource.getUserByUsername(username);
      return user;
    } else {
      return await localDataSource.getUserByUsername(username);
    }
  }

  Future<UserModel?> getMe() async {
    if (await connectivityResult.isConnected()) {
      final user = await remoteDataSource.getUserById(1);
      return user;
    } else {
      return await localDataSource.getUserById(1);
    }
  }
}
