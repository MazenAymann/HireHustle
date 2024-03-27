import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar customSnackBar({
  required icon,
  required text,
  required backgroundColor,
}) =>
    SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
