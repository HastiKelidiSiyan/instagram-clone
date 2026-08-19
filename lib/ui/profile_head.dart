import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final dynamic me;

  const ProfileHeader(this.me, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      child: Stack(
        alignment: Alignment.centerRight,
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
                me.username,
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
          Image.asset("assets/images/MenuIcon.png", height: 17, width: 20),
        ],
      ),
    );
  }
}