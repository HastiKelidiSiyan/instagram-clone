import 'package:instagram_clone/data_source/remote_data_source.dart';
import '../models/user_model.dart';

class UserRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<List<UserModel>> getUsers() async {
    return await remoteDataSource.getUsers();
  }

  Future<UserModel?> getUserById(int id) async {
    return await remoteDataSource.getUserById(id);
  }

  Future<UserModel?> addUser(UserModel user) async {
    return await remoteDataSource.addUser(user);
  }

  Future<UserModel?> getUserByUsername(String username) async {
    return await remoteDataSource.getUserByUsername(username);
  }

  Future<UserModel?> getMe() async {
    return await getUserById(1);
  
  }
}
