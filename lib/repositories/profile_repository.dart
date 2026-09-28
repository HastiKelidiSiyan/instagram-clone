import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/domain/profile_model.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class ProfileRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<ProfileModel> getProfile(String userId) async {
    if (await connectivityResult.isConnected()) {
      final profile = await remoteDataSource.getProfile(userId);
      await localDataSource.cacheUser(profile.user);
      for (final story in profile.stories) {
        await localDataSource.cacheStory(story);
      }
      for (final item in profile.posts) {
        await localDataSource.cacheUser(item.author);
        await localDataSource.cachePost(item.post);
        for (final media in item.media) {
          await localDataSource.cachePostMedia(media);
        }
        for (final like in item.likes) {
          await localDataSource.cacheUser(like.user);
          await localDataSource.cacheLike(like.like);
        }
        for (final comment in item.comments) {
          await localDataSource.cacheUser(comment.user);
          await localDataSource.cacheComment(comment.comment);
        }
      }
      return profile;
    }

    return localDataSource.getProfile(userId);
  }
}
