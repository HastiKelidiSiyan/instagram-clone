import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/domain/post_with_media.dart';
import 'package:instagram_clone/models/domain/profile_data.dart';
import 'package:instagram_clone/repositories/auth_repository.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:instagram_clone/ui/app_icon.dart';
import 'package:instagram_clone/ui/login_screen.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileData?> profileData;

  @override
  void initState() {
    super.initState();
    profileData = UserRepository().getProfileData(widget.user.id);
  }

  void _retry() {
    setState(() {
      profileData = UserRepository().getProfileData(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _profileAppBar(widget.user),
        body: FutureBuilder<ProfileData?>(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              final message = snapshot.error is AppFailure
                  ? failureMessage(snapshot.error as AppFailure)
                  : snapshot.error.toString();

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    IconButton(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            }

            final data = snapshot.data;

            if (data == null) {
              return const Center(child: Text('Profile not found.'));
            }

            return _profileBody(data, context);
          },
        ),
      ),
    );
  }
}

PreferredSizeWidget _profileAppBar(UserModel user) {
  Future<void> logout() async {
    final auth = AuthRepository();
    Get.off(LoginScreen());
    await auth.logout();
  }
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

  if (true) {
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
              InkWell(
                onTap: logout,
                child: AppIcon(
                  asset: "assets/images/MenuIcon.png",
                  height: 17,
                  width: 20,
                ),
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

Widget _profileBody(ProfileData data, BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: [
        _profileContents(data, context),
        SizedBox(height: 15),
        _editProfileButton(data.user),
        SizedBox(height: 1),
        _highlights(),
        _tabBar(),
        Container(height: 1, color: Color(0xdacecece)),
        Expanded(child: _tabBarView(data.posts)),
      ],
    ),
  );
}

Widget _tabBarView(List<PostWithMedia> posts) {
  return TabBarView(
    children: [
      CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final media = posts[index].media;

                if (media.isEmpty) {
                  return const Center(
                    child: Icon(Icons.broken_image_outlined),
                  );
                }

                return CachedNetworkImage(
                  imageUrl: media.first.mediaUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.broken_image_outlined),
                  ),
                );
              },
              childCount: posts.length,
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

Widget _profileContents(ProfileData data, BuildContext context) {
  final user = data.user;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        Row(
          children: [
            _profileProfile(user.avatarUrl ?? '', context),
            SizedBox(width: 35),
            ProfileInfo(number: data.posts.length.toString(), label: "Posts"),
            SizedBox(width: 21),
            ProfileInfo(
              number: data.followerCount.toString(),
              label: "Followers",
            ),
            SizedBox(width: 21),
            ProfileInfo(
              number: data.followingCount.toString(),
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
            Row(
              children: [Text(user.bio ?? '', style: TextStyle(fontSize: 12))],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _editProfileButton(UserModel user) {
  if (user.id != '1') {
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

Widget _profileProfile(
  String imageUrl,
  BuildContext context,
) {
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
