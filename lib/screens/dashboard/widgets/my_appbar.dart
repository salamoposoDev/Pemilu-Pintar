import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/screens/profile/profile_page.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'lib/assets/images/partai.png',
              scale: 1.7,
            ),
            Text(
              'Nama Partai',
              style: GoogleFonts.aBeeZee(
                  fontSize: 24.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.orange,
              size: 28.h,
            ),
            Gap(8.h),
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage())),
              child: Container(
                padding: EdgeInsets.all(4.h),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 28.h,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
