import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/network/dio_client.dart';
import 'package:instagram_clone/repositories/auth_repository.dart';
import 'package:instagram_clone/ui/loading_screen.dart';
import 'package:instagram_clone/ui/login_screen.dart';

void main() {
  DioClient.setupInterceptors();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: const SplashScreen()),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
      ),

      themeMode: ThemeMode.system,
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
      bool isLoggedIn = await AuthRepository().isLoggedIn();

      if (isLoggedIn) {
        Get.off(() => const LoadingScreen());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
  }
}
