import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:instagram_clone/ui/app_feedback.dart';
import 'package:instagram_clone/ui/home_body.dart';
import 'package:instagram_clone/ui/home_head.dart';
import 'package:instagram_clone/ui/profile_body.dart';
import 'package:instagram_clone/ui/profile_head.dart';
import 'package:instagram_clone/ui/profile_screen.dart' hide ProfileBody;

class Instagram extends StatefulWidget {
  const Instagram({required this.me ,super.key});

  final UserModel me;

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  int index = 0;

  void handleProfileTap(int userId) async {
    if (userId == 1) {
      setState(() {
        index = 4;
      });
    } else {
      UserModel? user = await UserRepository().getUserById(userId);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.me;

    final heads = [
      HomeHeader(me: currentUser),
      const Placeholder(child: Text("Explore Head")),
      const Placeholder(child: Text("Reel Head")),
      const Placeholder(child: Text("Shop Head")),
      ProfileHeader(currentUser),
    ];
    final bodies = [
      HomeBody(me: currentUser, onProfileTap: handleProfileTap),
      const Placeholder(child: Text("Explore Body")),
      const Placeholder(child: Text("Reel Body")),
      const Placeholder(child: Text("Shop Body")),
      ProfileBody(currentUser),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44),
        child: heads[index],
      ),
      body: bodies[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int currentIndex) {
          setState(() {
            index = currentIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/HomeIcon.png",
              height: 20,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/SearchIcon.png",
              height: 20,
              width: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/ReelsIcon.png",
              height: 20,
              width: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/ShopIcon.png",
              height: 20,
              width: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 9,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: currentUser.avatar,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
