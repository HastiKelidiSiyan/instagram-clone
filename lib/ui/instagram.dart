import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:instagram_clone/ui/home_body.dart';
import 'package:instagram_clone/ui/home_head.dart';
import 'package:instagram_clone/ui/profile_body.dart';
import 'package:instagram_clone/ui/profile_head.dart';
import 'package:instagram_clone/ui/profile_screen.dart' hide ProfileBody;

class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  List<Post> posts = PostRepository().getPosts();
  User me = UserRepository().getMe();

  late List<Widget> heads = [
    HomeHeader(),
    Placeholder(child: Text("Explore Head")),
    Placeholder(child: Text("Reel Head")),
    Placeholder(child: Text("Shop Head")),
    ProfileHeader(me),
  ];
  late List<Widget> bodies = [
    HomeBody(posts: posts, me: me, onProfileTap: handleProfileTap,),
    Placeholder(child: Text("Explore Body"),),
    Placeholder(child: Text("Reel Body")),
    Placeholder(child: Text("Shop Body")),
    ProfileBody(me),
  ];
  int index = 0;

  void handleProfileTap(int userId) {
    if (userId == 1) {
      setState(() {
        index = 4;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            user: UserRepository().getUserById(userId),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage(me.avatar),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}


