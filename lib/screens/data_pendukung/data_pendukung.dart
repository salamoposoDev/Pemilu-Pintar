import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/models/user.dart';
import 'package:pemilu_pintar/screens/data_pendukung/widgets/detail_pendukung_sheet.dart';
import 'package:pemilu_pintar/screens/tim_sukses/widgets/user_card.dart';
import 'package:pemilu_pintar/services/database_services.dart';

class DataPendukungPage extends StatefulWidget {
  const DataPendukungPage({super.key});

  @override
  State<DataPendukungPage> createState() => _DataPendukungPageState();
}

class _DataPendukungPageState extends State<DataPendukungPage> {
  DatabaseServices databaseServices = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Data Pendukung',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: StreamBuilder(
          stream: databaseServices.getDataPendukung(),
          builder: (context, snapshot) {
            List users = snapshot.data?.docs ?? [];
            if (users.isEmpty) {
              return Center(
                child: Text(
                  'Belum Ada Data',
                  style: GoogleFonts.poppins(fontSize: 18.sp),
                ),
              );
            }
            return ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  User dataUsers = users[index].data();
                  String userId = users[index].id;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: UserCard(
                      onTap: () {
                        showDetail(context);
                      },
                      name: dataUsers.name,
                      contact: userId,
                    ),
                  );
                });
          },
        ));
  }

  Future<dynamic> showDetail(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (contex) {
          return DetailPendukungSheet();
        });
  }
}
