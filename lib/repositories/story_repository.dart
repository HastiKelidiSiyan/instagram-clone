// import 'package:instagram_clone/data_source/local_data_source.dart';
// import 'package:instagram_clone/data_source/remote_data_source.dart';
// import 'package:instagram_clone/services/connection_availability%20.dart';

// import '../models/story_model.dart';

// class StoryRepository {
//   RemoteDataSource remoteDataSource = RemoteDataSource();
//   LocalDataSource localDataSource = LocalDataSource();
//   ConnectionAvailibility connectivityResult = ConnectionAvailibility();

//   Future<List<StoryModel>> getStories() async {
//     if (await connectivityResult.isConnected()) {
//       final stories = await remoteDataSource.getStories();
//       await localDataSource.cacheStories(stories);
//       return stories;
//     } else {
//       return await localDataSource.getStories();
//     }
//   }
// }
