import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/screens/data_pendukung/data_pendukung.dart';
import 'package:pemilu_pintar/screens/rekap_c_hasil/rekap_c_hasil.dart';
import 'package:pemilu_pintar/screens/rekap_survey/rekap_survey.dart';
import 'package:pemilu_pintar/screens/tim_sukses/tim_sukses.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {'icon': 'lib/assets/images/survey.png', 'text': 'Rekap C-Hasil'},
      {'icon': 'lib/assets/images/history_2.png', 'text': 'Rekap Survey'},
      {'icon': 'lib/assets/images/group.png', 'text': 'Tim Saksi'},
      {'icon': 'lib/assets/images/data.png', 'text': 'Data Pendukung'},
    ];

    final categoriesPage = [
      RekapCHasilPage(),
      RekapSurveyPage(),
      TimSuksesPage(),
      DataPendukungPage(),
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 55.h,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categoriesPage[index]));
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        categories[index]['icon'],
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Gap(4.h),
                Text(
                  categories[index]['text'],
                  style: GoogleFonts.roboto(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
