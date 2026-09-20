import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/story_view_model.dart';
import 'package:instagram_clone/models/domain/story_item_data.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class StoryRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<StoryModel>> getStories() async {
    if (await connectivityResult.isConnected()) {
      final stories = await remoteDataSource.getActiveStories();
      for (final story in stories) {
        await localDataSource.createStory(story);
      }
      return stories;
    }

    return localDataSource.getActiveStories();
  }

  Future<List<StoryItemData>> getActiveStoryItems() async {
    final db = AppDatabase.instance;
    final users = await (db.select(db.users)).get();
    if (users.isEmpty) return [];

    final currentUserId = users.first.id;

    if (await connectivityResult.isConnected()) {
      final items = await remoteDataSource.getActiveStoryItems(currentUserId);
      for (final item in items) {
        await localDataSource.cacheUser(item.author);
        await localDataSource.cacheStory(item.story);
      }
      return items;
    }

    return localDataSource.getActiveStoryItems(currentUserId);
  }

  Future<List<StoryModel>> getUserStories(String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getUserStories(userId);
    }

    return localDataSource.getUserStories(userId);
  }

  Future<StoryModel> createStory(StoryModel story) async {
    if (await connectivityResult.isConnected()) {
      final createdStory = await remoteDataSource.createStory(story);
      await localDataSource.createStory(createdStory);
      return createdStory;
    }

    await localDataSource.createStory(story);
    return story;
  }

  Future<void> deleteStory(String storyId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.deleteStory(storyId);
    }

    await localDataSource.deleteStory(storyId);
  }

  Future<bool> hasViewedStory(String storyId, String userId) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.hasViewedStory(storyId, userId);
    }

    return localDataSource.hasViewedStory(storyId, userId);
  }

  Future<StoryViewModel> addStoryView(StoryViewModel view) async {
    if (await connectivityResult.isConnected()) {
      final addedView = await remoteDataSource.addStoryView(view);
      await localDataSource.addStoryView(addedView);
      return addedView;
    }

    await localDataSource.addStoryView(view);
    return view;
  }
}
