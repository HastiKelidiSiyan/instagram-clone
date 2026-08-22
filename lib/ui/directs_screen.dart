
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/message_repository.dart';
import 'package:instagram_clone/repositories/user_repository.dart';

import '../models/message_model.dart';

class DirectsScreen extends StatelessWidget {

  DirectsScreen({required this.me, super.key});

  final UserModel me;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: Head(me: me,),
        body: const DirectsList(),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFAFAFAFA),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/BlueCameraIcon.png",
            height: 19,
            width: 20,
          ),
          SizedBox(width: 8),
          Text(
            "Camera",
            style: TextStyle(fontSize: 13, color: Color(0xffa3897f)),
          ),
        ],
      ),
    );
  }
}

class DirectsList extends StatelessWidget {
  const DirectsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: MessageRepository().getMessages(), builder: (context, snapshot) {
      return ListView.separated(
        itemCount: snapshot.data?.length ?? 0,
        separatorBuilder: (context, index) => Divider(height: 1, color: Color(0xffC7C7CC)),
        itemBuilder: (context, index) {
          if (snapshot.hasData) {
            final message = snapshot.data![index];
            return direct(message);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }

  SizedBox direct(MessageModel message) {
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          HighlightProfiles(imageUrl: message.user.avatar),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message.user.username, style: TextStyle(fontSize: 13)),
              Row(
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      message.lastMessage,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "· ${getTimeDistance(message.date)}",
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
}

class Head extends StatelessWidget implements PreferredSizeWidget {

  const Head({required this.me, super.key});

  final UserModel me;

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFAFAFAFA),
      toolbarHeight: 44,
      titleSpacing: 0,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/images/backIcon.png",
              height: 17,
              width: 9,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              me.username,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Image.asset("assets/images/AddIcon.png", height: 19, width: 19),
          SizedBox(width: 18),
        ],
      ),
    );
  }
}

class HighlightProfiles extends StatelessWidget {
  const HighlightProfiles({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffC7C7CC),
      ),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
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
