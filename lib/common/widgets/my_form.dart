import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyForm extends StatelessWidget {
  const MyForm({
    super.key,
    required this.hintText,
    required this.label,
    this.icon,
    required this.validator,
    this.controller,
  });
  final String hintText;
  final String label;
  final IconData? icon;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: Colors.red)),
          labelText: hintText,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(
                color: Colors.grey,
              )),
        ),
        validator: validator,
      ),
    );
  }
}
