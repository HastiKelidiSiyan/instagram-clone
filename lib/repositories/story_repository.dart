import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/domain/home_story.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class StoryRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<StoryGroupModel>> getStoryGroups(String currentUserId) async {
    if (await connectivityResult.isConnected()) {
      final groups = await remoteDataSource.getStoryGroups(currentUserId);
      for (final group in groups) {
        await localDataSource.cacheUser(group.user);
        for (final story in group.stories) {
          await localDataSource.cacheStory(story);
        }
      }
      return groups;
    }

    return localDataSource.getStoryGroups(currentUserId);
  }
}
