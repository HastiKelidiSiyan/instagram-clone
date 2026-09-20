import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/story_repository.dart';

void main() {
  test('post feed keeps self and followed users only, newest first', () {
    final now = DateTime.now();

    final posts = [
      PostModel(
        id: 'post-1',
        userId: 'self',
        caption: 'self-post',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      PostModel(
        id: 'post-2',
        userId: 'followed-user',
        caption: 'followed-post',
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
      PostModel(
        id: 'post-3',
        userId: 'unrelated-user',
        caption: 'unrelated-post',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      PostModel(
        id: 'post-4',
        userId: 'another-followed-user',
        caption: 'newest-followed-post',
        createdAt: now,
      ),
    ];

    final result = filterFeedPosts(
      posts,
      'self',
      {'followed-user', 'another-followed-user'},
    );

    expect(result.map((post) => post.id).toList(), [
      'post-4',
      'post-1',
      'post-2',
    ]);
  });

  test('story feed keeps self and followed users only, newest first', () {
    final now = DateTime.now();

    final stories = [
      StoryModel(
        id: 'story-1',
        userId: 'self',
        mediaUrl: 'self-story',
        mediaType: 'image',
        createdAt: now.subtract(const Duration(minutes: 10)),
        expiresAt: now.add(const Duration(hours: 1)),
      ),
      StoryModel(
        id: 'story-2',
        userId: 'followed-user',
        mediaUrl: 'followed-story',
        mediaType: 'image',
        createdAt: now.subtract(const Duration(minutes: 20)),
        expiresAt: now.add(const Duration(hours: 1)),
      ),
      StoryModel(
        id: 'story-3',
        userId: 'unrelated-user',
        mediaUrl: 'unrelated-story',
        mediaType: 'video',
        createdAt: now.subtract(const Duration(minutes: 30)),
        expiresAt: now.add(const Duration(hours: 1)),
      ),
      StoryModel(
        id: 'story-4',
        userId: 'another-followed-user',
        mediaUrl: 'newest-story',
        mediaType: 'image',
        createdAt: now,
        expiresAt: now.add(const Duration(hours: 1)),
      ),
    ];

    final result = filterFeedStories(
      stories,
      'self',
      {'followed-user', 'another-followed-user'},
    );

    expect(result.map((story) => story.id).toList(), [
      'story-4',
      'story-1',
      'story-2',
    ]);
  });
}
