import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/story_model.dart';

class StoryListItem extends StatelessWidget {
  const StoryListItem({super.key, required this.story, required this.onTap});

  final StoryModel story;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: story.seen
                      ? LinearGradient(
                          colors: [Colors.grey, Colors.grey],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                      : LinearGradient(
                          colors: [Color(0xFA9E2692), Color(0xFAFAA958)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                ),
              ),
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: story.user.avatar,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(story.user.username, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}