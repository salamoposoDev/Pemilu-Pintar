import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/common/widgets/my_solid_button.dart';
import 'package:pemilu_pintar/screens/add_tim_sukses/add_tim_sukses.dart';
import 'package:pemilu_pintar/screens/tim_sukses/widgets/user_card.dart';

class TimSuksesPage extends StatelessWidget {
  const TimSuksesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tim Sukses',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  'Urutkan',
                  style: GoogleFonts.poppins(),
                ),
                Gap(4.w),
                const Icon(Icons.short_text),
              ],
            ),
          ),
          Gap(16.h),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: UserCard(
                  name: 'salahuddn',
                  contact: '00000000000',
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: MySolidButton(
                    text: 'Tambahkan Tim Survey',
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTimSurveyPage())),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
