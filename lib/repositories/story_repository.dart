import 'package:instagram_clone/data_source/remote_data_source.dart';

import '../data/data_constants.dart';
import '../models/story_model.dart';

class StoryRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  
  Future<List<StoryModel>> getStories() async {
    return await remoteDataSource.getStories();
  }
}
