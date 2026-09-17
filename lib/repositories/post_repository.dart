import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class PostRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalDataSource localDataSource = LocalDataSource();
  ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<PostModel>> getPosts() async {
    if (await connectivityResult.isConnected()) {
      final posts = await remoteDataSource.getPosts();
      await localDataSource.cachePosts(posts);
      return posts;
    } else {
      return await localDataSource.getPosts();
    }
  }
}
