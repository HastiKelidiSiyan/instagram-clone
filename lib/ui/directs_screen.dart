import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/ui/app_icon.dart';

class DirectsScreen extends StatelessWidget {
  const DirectsScreen({super.key, required this.currentUser});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _directsAppBar(currentUser),
        body: _emptyDirectsList(),
        bottomNavigationBar: _footer(),
      ),
    );
  }
}

PreferredSizeWidget _directsAppBar(UserModel me) {
  return AppBar(
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
            Get.back();
          },
          child: AppIcon(
            asset: "assets/images/backIcon.png",
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
        AppIcon(asset: "assets/images/AddIcon.png", height: 19, width: 19),
        SizedBox(width: 18),
      ],
    ),
  );
}

Widget _emptyDirectsList() {
  return Center(
    child: Text(
      'No conversations yet',
      style: TextStyle(fontSize: 13, color: Colors.grey),
    ),
  );
}

Widget _footer() {
  return SizedBox(
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
