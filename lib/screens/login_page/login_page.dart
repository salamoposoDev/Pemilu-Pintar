import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/screens/dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      // log('Email: $email, Password: $password');
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credential.user!.uid;
      log(userId);
      if (userId.isEmpty) {
        return log('Gagal Login');
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage(
                    email: credential.user!.email.toString(),
                  )));
    } on FirebaseAuthException catch (e) {
      // log(e.code);
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final screenWidht = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade200,
          Colors.orange.shade200,
        ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(50.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilkada',
                        style: GoogleFonts.poppins(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Pintar',
                        style: GoogleFonts.poppins(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        'Silahkan Login Untuk Melanjutkan',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      // Image.asset(
                      //   'lib/assets/images/Logo_Pemilu_2024.svg.png',
                      //   scale: 4,
                      // ),
                    ],
                  ),
                  Gap(200.h),
                  Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Email',
                          hintText: 'Masukkan Email',
                          hintStyle: GoogleFonts.poppins(),
                          suffixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Masukkan Alamat Email Yang Valid';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Password',
                          hintText: 'Masukkan Password',
                          hintStyle: GoogleFonts.poppins(),
                          suffixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        obscureText: !showPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Password';
                          }
                          if (value.length < 6) {
                            return 'Password Minimal 6 Karakter';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blue,
                            value: showPassword,
                            onChanged: (value) {
                              setState(() {
                                showPassword = value!;
                              });
                            },
                          ),
                          Text(
                            'Tampilakan Password',
                            style: GoogleFonts.poppins(),
                          )
                        ],
                      ),
                      Gap(50.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(double.maxFinite, 50.h),
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login(context);
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DashboardPage()));
                        },
                        child: Text(
                          'Masuk',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  Gap(40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hanya tim sukses terdaftar yang bisa masuk!',
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
