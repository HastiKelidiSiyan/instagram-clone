import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/instagram.dart';
import 'package:instagram_clone/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: const SplashScreen()),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
} 

class _SplashScreenState extends State<SplashScreen> {  

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/InstagramIcon.png',
          width: 120,
          height: 120,
        ),
      ),
    );
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isloggedIn = prefs.getBool('isLoggedIn') ?? false;

      if(isloggedIn){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Instagram()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }
}