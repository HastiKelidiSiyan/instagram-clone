import '../data/data_constants.dart';
import '../models/post.dart';

class PostRepository {
  List<Post> getPosts() {
    return DataConstants.posts.map((e) => Post.fromJson(e)).toList();
  }
}
