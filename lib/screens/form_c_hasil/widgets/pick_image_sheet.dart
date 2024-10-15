import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PickImageSheet extends StatelessWidget {
  const PickImageSheet({
    super.key,
    required this.onTapGalery,
    required this.onTapCamera,
  });
  final VoidCallback onTapGalery;
  final VoidCallback onTapCamera;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Gambar',
                style: GoogleFonts.poppins(fontSize: 18.sp),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: onTapCamera,
                    child: Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Image.asset('lib/assets/icons/camera.png'),
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Kamera',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: onTapGalery,
                    child: Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Image.asset('lib/assets/icons/galery.png'),
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Galery',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ],
          ),
          Gap(16.h),
        ],
      ),
    );
  }
}
