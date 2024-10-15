import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CardTotalSuara extends StatelessWidget {
  const CardTotalSuara({
    super.key,
    required this.title,
    required this.percen,
    required this.totalSuara,
    required this.icon,
    this.backgroundColor = Colors.red,
    required this.progressColor,
    required this.backgroundColorPercentIndicator,
  });
  final String title;
  final double percen;
  final int totalSuara;
  final IconData icon;
  final Color? backgroundColor;
  final Color progressColor;
  final Color backgroundColorPercentIndicator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(-0, 2),
                blurRadius: 2)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularPercentIndicator(
                percent: percen,
                radius: 35,
                lineWidth: 10,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: progressColor,
                backgroundColor: backgroundColorPercentIndicator,
                center: Text(
                  '$percen%',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gap(16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(),
                  ),
                  Gap(8.h),
                  Row(
                    children: [
                      Text(
                        totalSuara.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        'Suara',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.menu),
        ],
      ),
    );
  }
}
