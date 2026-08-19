import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/directs_screen.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(46);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      toolbarHeight: 44,
      titleSpacing: 0,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Row(
          children: [
            Image.asset(
              "assets/images/InstagramLogo.png",
              height: 36,
              width: 100,
            ),
            Spacer(),
            Row(
              children: [
                Image.asset("assets/images/AddIcon.png", height: 17, width: 17),
                SizedBox(width: 16),
                Image.asset(
                  "assets/images/HeartIcon.png",
                  height: 17,
                  width: 17,
                ),
                SizedBox(width: 16),
                InkWell(
                  child: Image.asset(
                    "assets/images/DirectIcon.png",
                    height: 17,
                    width: 17,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DirectsScreen()),
                    );
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
