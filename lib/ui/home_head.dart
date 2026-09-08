import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/ui/AppIcon.dart';
import 'package:instagram_clone/ui/directs_screen.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({required this.me, super.key});

  final UserModel me;

  @override
  Size get preferredSize => const Size.fromHeight(46);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 44,
      titleSpacing: 0,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Row(
          children: [
            AppIcon(asset:  "assets/images/InstagramLogo.png",
              height: 36,
              width: 100,
            ),
            Spacer(),
            Row(
              children: [
                AppIcon(asset:  "assets/images/AddIcon.png", height: 17, width: 17),
                SizedBox(width: 16),
                AppIcon(asset:  "assets/images/HeartIcon.png",
                  height: 17,
                  width: 17,
                ),
                SizedBox(width: 16),
                InkWell(
                  child: AppIcon(asset:  "assets/images/DirectIcon.png",
                    height: 17,
                    width: 17,
                  ),
                  onTap: () {
                    Get.to(() => DirectsScreen(me: me));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
