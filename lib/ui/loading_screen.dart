import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/ui/app_feedback.dart';
import 'package:instagram_clone/ui/instagram.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget content = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await Future.delayed(const Duration(seconds: 5));

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('currentUserId');

    if (userId == null) {
      return;
    }

    try {
      await context.read<UserProvider>().getCurrentUser(userId);

      if (!mounted) return;

      final user = context.read<UserProvider>().currentUser;

      if (user != null) {
        Get.off(() => const Instagram());
      } else {
        setState(() {
          content = IconButton(
            onPressed: _loadUser,
            icon: const Icon(Icons.refresh),
          );
        });
      }
    } on AppFailure catch (e) {
      if (!mounted) return;
      AppFeedback.showFailure(context, e);
    } catch (e) {
      if (!mounted) return;
      AppFeedback.showException(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: content,
      ),
    );
  }
}