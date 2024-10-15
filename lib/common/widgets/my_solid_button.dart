import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySolidButton extends StatelessWidget {
  const MySolidButton(
      {super.key, required this.text, this.onTap, required this.color});
  final String text;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: const Size(double.infinity, 50),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
    );
  }
}
