import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';

class DirectListItem extends StatelessWidget {
  const DirectListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final DirectConversationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final user = item.otherParticipant;
    final latestMessage = item.latestMessage;

    final messageText =
        latestMessage?.text ?? 'Start a conversation';

    final messageTime =
        latestMessage?.createdAt ??
        item.conversation.createdAt;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 28,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl ?? '',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          messageText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${getTimeDistance(messageTime)}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/CameraIcon.png',
              height: 22,
              width: 23,
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  String getTimeDistance(DateTime time) {
    final difference = DateTime.now().difference(
      time.toLocal(),
    );

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo';
    } else {
      return '${(difference.inDays / 365).floor()}y';
    }
  }
}