import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/post_model.dart';

class PostRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  
  Future<List<PostModel>> getPosts() async {
    return await remoteDataSource.getPosts();
  }
}
