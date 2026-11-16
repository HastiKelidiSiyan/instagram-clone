import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/domain/post_with_media.dart';
import 'package:instagram_clone/models/follow_model.dart';
import 'package:instagram_clone/models/like_model.dart';
import 'package:instagram_clone/models/post_media_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/domain/post_item.dart';
import 'package:instagram_clone/database/database.dart' hide Post;
import 'package:instagram_clone/services/connection_availability%20.dart';

class PostRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  // final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<PostItem>> getFeedItems(String currentUserId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getFeedItems(currentUserId);
    }

    return [];
  }

  Future<PostWithMedia?> getPostWithMedia(String postId) async {
        if (await connectivityResult.isConnected()) {
      return remoteDataSource.getPostWithMedia(postId);
    }

    return null;
  }


}
