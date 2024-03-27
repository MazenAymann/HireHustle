import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customContainer({required stringData, required context, required height, required width}) => Container(
  height: height ,
  width: width ,
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 43, 44, 57),
    borderRadius: BorderRadius.circular(20.w),
  ),
  padding: EdgeInsets.all(10.w),
  child: Center(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Text(
        stringData,
        style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15.sp
        ),
      ),
    ),
  ),
);