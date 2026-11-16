import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/domain/story_item_data.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class StoryRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  // final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<StoryItemData>> getActiveStoryItems(String currentUserId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getActiveStoryItems(currentUserId);
    }
    return [];
  }
}
