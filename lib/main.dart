import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pemilu_pintar/common/widgets/message_util.dart';
import 'package:pemilu_pintar/firebase_options.dart';
import 'package:pemilu_pintar/screens/dashboard/dashboard.dart';

import 'package:pemilu_pintar/screens/login_page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  MyApp({
    this.user,
    super.key,
  });
  User? user;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 806),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: MessageUtil.ScaffoldMessengerkey,
          home: user == null
              ? LoginPage()
              : DashboardPage(
                  email: user!.email.toString(),
                ),
        );
      },
    );
  }
}
