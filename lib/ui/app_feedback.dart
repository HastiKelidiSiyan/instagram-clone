import 'package:flutter/material.dart';
import 'package:instagram_clone/models/app_failure.dart';

class AppFeedback {
  static void showFailure(BuildContext context, AppFailure failure) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 124, 39, 39),
        content: Text(
          style: TextStyle(color: Colors.red),
          failureMessage(failure)),
      ),
    );
  }

  static void showException(BuildContext context, String error) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 124, 39, 39),
        content: Text(
          style: TextStyle(color: Colors.red),
          error),
        ),
    );
  }
}
