import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget SecondaryButton({
  required buttonLabel,
  required onPressed,
}) =>
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3366FF), const  Color(0xFF00CCFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonLabel,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15.sp,
          ),
        ),
        style: TextButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
