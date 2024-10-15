import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pemilu_pintar/common/widgets/my_solid_button.dart';
import 'package:pemilu_pintar/screens/login_page/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Saya'),
      ),
      body: Center(
        child: Text('Login Sebagai $email'),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.h),
        child: Row(
          children: [
            Expanded(
                child: MySolidButton(
                    text: 'Logout',
                    color: Colors.blue,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }).catchError((error) {
                        print(error.toString());
                      });
                    })),
          ],
        ),
      ),
    );
  }
}
