import '../data/data_constants.dart';
import '../models/story.dart';

class StoryRepository {
  List<Story> getStories() {
    return DataConstants.stories.map((e) => Story.fromJson(e)).toList();
  }
}
