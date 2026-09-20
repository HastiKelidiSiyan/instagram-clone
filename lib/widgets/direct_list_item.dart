import 'package:flutter/material.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/widgets/story_item.dart';

class DirectListItem extends StatelessWidget {
  const DirectListItem({
    super.key,
    required this.onTap,
    required this.conversation,
  });

  final ConversationModel conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          CircleAvatar(
            radius: 28,
            child: ClipOval(
              child: Icon(Icons.person),
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(conversation.id, style: TextStyle(fontSize: 13)),
              Row(
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "· ${getTimeDistance(conversation.createdAt)}",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Image.asset("assets/images/CameraIcon.png", height: 22, width: 23),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  String getTimeDistance(DateTime pastTime) {
    final now = DateTime.now();
    final difference = now.difference(pastTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y';
    }
  }
}
