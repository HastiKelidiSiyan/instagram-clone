import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/domain/feed_item.dart';
import 'package:instagram_clone/ui/app_icon.dart';

class PostListItem extends StatelessWidget {
  final FeedItem feedItem;
  final Function(int) onProfileTap;

  const PostListItem({
    super.key,
    required this.feedItem,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final post = feedItem.post;
    return SizedBox(
      child: Column(
        children: [
          _postHeader(feedItem, onProfileTap),
          SizedBox(height: 4),
          _postImage(feedItem),
          SizedBox(height: 4),
          _postFooter(feedItem, onProfileTap),
        ],
      ),
    );
  }
}

Widget _postHeader(FeedItem item, Function(int) onProfileTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Row(
      children: [
        InkWell(
          child: CircleAvatar(
            radius: 16,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.author.avatarUrl ?? '',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          onTap: () {
            onProfileTap(int.tryParse(item.author.id) ?? 0);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Text(
                  item.author.username,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  onProfileTap(int.tryParse(item.author.id) ?? 0);
                },
              ),
              Text('', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
        Spacer(),
        AppIcon(asset: "assets/images/ThreeDotsIcon.png", height: 3, width: 13),
      ],
    ),
  );
}

Widget _postImage(FeedItem item) {
  return SizedBox(
    width: double.infinity,
    child: CachedNetworkImage(
      height: 320,
      fit: BoxFit.fitHeight,
      imageUrl: item.media.isNotEmpty ? item.media.first.mediaUrl : '',
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    ),
  );
}

Widget _postFooter(FeedItem item, Function(int) onProfileTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postActions(),
        SizedBox(height: 4),
        _postLikes(item, onProfileTap),
        _postCaption(item, onProfileTap),
        _postTopComment(item),
      ],
    ),
  );
}

Widget _postActions() {
  return Row(
    children: [
      AppIcon(asset: "assets/images/HeartIcon.png", height: 24, width: 24),
      SizedBox(width: 12),
      AppIcon(asset: "assets/images/CommentIcon.png", height: 24, width: 24),
      SizedBox(width: 12),
      AppIcon(asset: "assets/images/DirectIcon.png", height: 24, width: 24),
      Spacer(),
      AppIcon(asset: "assets/images/BookmarkIcon.png", height: 24, width: 24),
    ],
  );
}

Widget _postLikes(FeedItem item, Function(int) onProfileTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        InkWell(
          child: CircleAvatar(
            radius: 8.5,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.latestLiker?.avatarUrl ?? '',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          onTap: () {
            if (item.latestLiker != null)
              onProfileTap(int.tryParse(item.latestLiker!.id) ?? 0);
          },
        ),
        SizedBox(width: 7),
        Row(
          children: [
            Text("Liked by", style: TextStyle(fontSize: 12)),
            SizedBox(width: 2),
            InkWell(
              child: Text(
                item.latestLiker?.username ?? '',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (item.latestLiker != null)
                  onProfileTap(int.tryParse(item.latestLiker!.id) ?? 0);
              },
            ),
            SizedBox(width: 2),
            Text("and", style: TextStyle(fontSize: 12)),
            SizedBox(width: 2),
            Text(
              "${item.likeCount > 0 ? item.likeCount - 1 : 0} others",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _postCaption(FeedItem item, Function(int) onProfileTap) {
  return Row(
    children: [
      InkWell(
        child: Text(
          item.author.username,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          onProfileTap(int.tryParse(item.author.id) ?? 0);
        },
      ),
      SizedBox(width: 2),
      Text(item.post.caption, style: TextStyle(fontSize: 14)),
    ],
  );
}

Widget _postTopComment(FeedItem item) {
  return Column(
    children: [
      SizedBox(height: 6),
      Text(
        "View the ${item.commentCount} comments",
        style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.4)),
      ),
    ],
  );
}
