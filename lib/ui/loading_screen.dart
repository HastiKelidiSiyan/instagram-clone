// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:instagram_clone/models/app_failure.dart';
// import 'package:instagram_clone/models/user_model.dart';
// import 'package:instagram_clone/repositories/user_repository.dart';
// import 'package:instagram_clone/ui/app_feedback.dart';
// import 'package:instagram_clone/ui/instagram.dart';

// class LoadingScreen extends StatefulWidget {
//   const LoadingScreen({super.key});

//   @override
//   State<LoadingScreen> createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   Widget content = CircularProgressIndicator();
//   UserModel? user;
//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   void _loadUser() async {
//     await Future.delayed(const Duration(seconds: 5), () async {
//       try {
//         user = await UserRepository().getMe();
//       } on AppFailure catch (e) {
//         AppFeedback.showFailure(context, e);
//       } catch (e) {
//         AppFeedback.showException(context, e.toString());
//       }
//       if (mounted) {
//         setState(() {});
//       }

//       if (user != null) {
//         final UserModel me = user!;
//         Get.off(() => Instagram(me: me));
//       } else {
//         content = IconButton(onPressed: _loadUser, icon: Icon(Icons.refresh));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: content),
//     );
//   }
// }
