import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MessageType { error, normal }

class MessageUtil {
  static final GlobalKey<ScaffoldMessengerState> ScaffoldMessengerkey =
      GlobalKey<ScaffoldMessengerState>();
  static void showMessage(
      BuildContext context, String message, MessageType type) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16.h),
      padding: const EdgeInsets.all(20),
      backgroundColor: type == MessageType.error
          ? Colors.red.shade400
          : Colors.blue.shade400,
      content: Text(message),
    );
    ScaffoldMessengerkey.currentState?.showSnackBar(snackBar);
  }
}
