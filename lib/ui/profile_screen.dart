import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel? user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44),
          child: Head(user!),
        ),
        body: ProfileBody(user!),
      ),
    );
  }
}

class Head extends StatelessWidget {
  final dynamic user;

  const Head(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/PrivateIcon.png",
                height: 12,
                width: 9,
              ),
              SizedBox(width: 6),
              Text(
                user.username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Image.asset(
                "assets/images/AccountsListIcon.png",
                height: 6,
                width: 11,
              ),
            ],
          ),
          Row(
            children: [
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
              Image.asset("assets/images/MenuIcon.png", height: 17, width: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final UserModel user;

  const ProfileBody(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileContents(user),
        SizedBox(height: 15),
        EditProfileButton(),
        SizedBox(height: 1),
        Highlights(),
        Container(height: 1, color: Color(0xdacecece)),
        Spacer(),
      ],
    );
  }
}

class Highlights extends StatelessWidget {
  const Highlights({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
      child: Row(
        children: [
          Column(
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/AddIcon.png",
                    height: 18,
                    width: 18,
                  ),
                ),
              ),
              SizedBox(height: 3),
              Text("New", style: TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(width: 18),
          Column(
            children: [
              HighlightProfiles(imageUrl: "assets/images/image13.png"),
              SizedBox(height: 3),
              Text("Friends", style: TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(width: 18),
          Column(
            children: [
              HighlightProfiles(imageUrl: "assets/images/image12.png"),
              SizedBox(height: 3),
              Text("Sports", style: TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(width: 18),
          Column(
            children: [
              HighlightProfiles(imageUrl: "assets/images/image11.png"),
              SizedBox(height: 3),
              Text("Design", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ProfileContents extends StatelessWidget {
  final dynamic me;

  const ProfileContents(this.me, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              ProfileProfile(imageUrl: me.avatar),
              SizedBox(width: 35),
              ProfileInfo(number: me.totalPosts.toString(), label: "Posts"),
              SizedBox(width: 21),
              ProfileInfo(
                number: me.totalFollowers.toString(),
                label: "Followers",
              ),
              SizedBox(width: 21),
              ProfileInfo(
                number: me.totalFollowings.toString(),
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
                me.name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1),
              Row(children: [Text(me.bio, style: TextStyle(fontSize: 12))]),
            ],
          ),
        ],
      ),
    );
  }
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

class NavigationBar extends StatelessWidget {
  final dynamic me;

  const NavigationBar(this.me, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          Image.asset("assets/images/HomeIcon.png", height: 20, width: 20),
          SizedBox(width: 58),
          Image.asset("assets/images/SearchIcon.png", height: 20, width: 20),
          SizedBox(width: 58),
          Image.asset("assets/images/ReelsIcon.png", height: 20, width: 20),
          SizedBox(width: 58),
          Image.asset("assets/images/ShopIcon.png", height: 20, width: 20),
          SizedBox(width: 58),
          CircleAvatar(radius: 9, backgroundImage: NetworkImage(me.avatar)),
        ],
      ),
    );
  }
}

class ProfileProfile extends StatelessWidget {
  final String imageUrl;

  const ProfileProfile({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 43,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }
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
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }
}
