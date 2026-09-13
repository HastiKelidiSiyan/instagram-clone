import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:instagram_clone/ui/app_icon.dart';
import 'package:instagram_clone/ui/home_screen.dart';

import 'package:instagram_clone/ui/profile_screen.dart' hide ProfileBody;

class Instagram extends StatefulWidget {
  const Instagram({required this.me, super.key});

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
      Get.to(() => ProfileScreen(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.me;


    final screens = [
      HomeScreen(me: currentUser, onProfileTap: handleProfileTap),
      const Placeholder(child: Text("Explore Body")),
      const Placeholder(child: Text("Reel Body")),
      const Placeholder(child: Text("Shop Body")),
      ProfileScreen(user: currentUser),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int currentIndex) {
          setState(() {
            index = currentIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: AppIcon(
              asset: "assets/images/HomeIcon.png",
              height: 20,
              width: 20,
            ),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AppIcon(
              asset: "assets/images/SearchIcon.png",
              height: 20,
              width: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: AppIcon(
              asset: "assets/images/ReelsIcon.png",
              height: 20,
              width: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: AppIcon(
              asset: "assets/images/ShopIcon.png",
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
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
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
