import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/repositories/auth_repository.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:instagram_clone/ui/login_screen.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel? userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    UserModel user;
    //  = UserRepository().getUserById(userId);
    // List<Post> posts = PostRepository().getPosts(userId);
    return SafeArea(
      child: Scaffold(
        appBar: _profileAppBar(user!),
        body: _profileBody(user!, context),
      ),
    );
  }
}

PreferredSizeWidget _profileAppBar(UserModel user) {
  Widget content = Row(
    children: [
      SizedBox(width: 15),
      Center(
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: SizedBox(
            height: 17,
            width: 9,
            child: AppIcon(
              asset: "assets/images/backIcon.png",
            ),
          ),
        ),
      ),
      SizedBox(width: 15),
      Text(
        user.username,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );

  if (user.userId == 1) {
    content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                asset: "assets/images/PrivateIcon.png",
                height: 12,
                width: 9,
              ),
              SizedBox(width: 6),
              Text(
                user.username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              AppIcon(
                asset: "assets/images/AccountsListIcon.png",
                height: 6,
                width: 11,
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              AppIcon(
                asset: "assets/images/MenuIcon.png",
                height: 17,
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  return AppBar(
    toolbarHeight: 44,
    titleSpacing: 0,
    leadingWidth: 0,
    automaticallyImplyLeading: false,
    title: content,
  );
}

Widget _profileBody(UserModel user, BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: [
        _profileContents(user, context),
        SizedBox(height: 15),
        _editProfileButton(user),
        SizedBox(height: 1),
        _highlights(),
        _tabBar(),
        Container(height: 1, color: Color(0xdacecece)),
        Expanded(child: _tabBarView(user)),
      ],
    ),
  );
}

Widget _tabBarView(UserModel user) {
  return TabBarView(
    children: [
      CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                );
              },
              childCount: 20,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 140.0,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ),
          ),
        ],
      ),
      Center(
        child: Text("f"),
      ),
    ],
  );
}

Widget _tabBar() {
  return TabBar(
    tabs: [
      Tab(
        icon: Icon(Icons.grid_4x4),
      ),
      Tab(
        icon: Icon(Icons.person),
      ),
    ],
  );
}

Widget _profileContents(UserModel user, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        Row(
          children: [
            _profileProfile(user.avatar, context),
            SizedBox(width: 35),
            ProfileInfo(number: user.totalPosts.toString(), label: "Posts"),
            SizedBox(width: 21),
            ProfileInfo(
              number: user.totalFollowers.toString(),
              label: "Followers",
            ),
            SizedBox(width: 21),
            ProfileInfo(
              number: user.totalFollowings.toString(),
              label: "Following",
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1),
            Row(children: [Text(user.bio, style: TextStyle(fontSize: 12))]),
          ],
        ),
      ],
    ),
  );
}

Widget _editProfileButton(UserModel user) {
  if (user.userId != 1) {
    return SizedBox.shrink();
  }
  return Container(
    height: 29,
    width: 343,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Color(0xffcecece)),
    ),
    child: Center(
      child: Text(
        "Edit Profile",
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _highlights() {
  List<String> highlightImages = [
    "assets/images/image13.png",
    "assets/images/image12.png",
    "assets/images/image11.png",
    "assets/images/image10.png",
  ];
  return SizedBox(
    height: 94,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: highlightImages.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          return HighlightProfiles(imageUrl: highlightImages[index]);
        },
      ),
    ),
  );
}

class ProfileInfo extends StatelessWidget {
  final String number;
  final String label;

  const ProfileInfo({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              number,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(label, style: TextStyle(fontSize: 13)),
          ],
        ),
      ],
    );
  }
}

Widget _profileProfile(String imageUrl,
BuildContext context, ) {
  return Column(
    children: [
      Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffC7C7CC),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 91,
          height: 91,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 43,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class HighlightProfiles extends StatelessWidget {
  const HighlightProfiles({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffC7C7CC),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 28,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
