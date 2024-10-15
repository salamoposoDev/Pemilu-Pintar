import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pemilu_pintar/common/widgets/my_solid_button.dart';
import 'package:pemilu_pintar/screens/dashboard/widgets/card_total_suara.dart';
import 'package:pemilu_pintar/screens/dashboard/widgets/categories.dart';
import 'package:pemilu_pintar/screens/dashboard/widgets/my_appbar.dart';
import 'package:pemilu_pintar/screens/dashboard/widgets/pie_cart.dart';
import 'package:pemilu_pintar/screens/form_c_hasil/form_c_hasil.dart';
import 'package:pemilu_pintar/screens/form_pendukung/from_pendukung_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    required this.email,
    super.key,
  });
  static String routeName = '/';
  final String email;

  @override
  Widget build(BuildContext context) {
    // log(email);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: const MyAppBar(),
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CardTotalSuara(
                      backgroundColor: Colors.orange.shade100,
                      backgroundColorPercentIndicator: Colors.blue.shade100,
                      progressColor: Colors.blue,
                      title: 'Total Suara Survey',
                      percen: 0.25,
                      totalSuara: 123456,
                      icon: Icons.menu,
                    ),
                    Gap(16.h),
                    CardTotalSuara(
                      backgroundColorPercentIndicator: Colors.orange.shade100,
                      backgroundColor: Colors.blue.shade100,
                      progressColor: Colors.orange,
                      title: 'Total Hasil Quict Count',
                      percen: 0.6,
                      totalSuara: 120000,
                      icon: Icons.menu,
                    ),
                  ],
                ),
              ),
              Gap(16.h),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade100,
                      Colors.orange.shade100,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Categories(),
                    PieCart(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MySolidButton(
                          text: 'Input Data Pendukung',
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormPendukungPage();
                            }));
                          },
                        ),
                        MySolidButton(
                          text: 'Input C Hasil',
                          color: Colors.orange,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormCHasil();
                            }));
                          },
                        ),
                      ],
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
