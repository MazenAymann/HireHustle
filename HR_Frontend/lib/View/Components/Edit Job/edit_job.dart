import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomJobTextFormField({
  required labelText,
  required labelColor,
  required textColor,
  required cursorColor,
  required borderColor,
  required borderWidth,
  required borderRadius,
  required focusedBorderColor,
  required focusedBorderWidth,
  required focusedBorderRadius,
  required controller,
  required maxLines,
  required enabled,
}) =>
    TextFormField(
      enabled: enabled,
      style: GoogleFonts.poppins(
        color: textColor,
      ),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(43, 47, 54, 1.0),
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          color: labelColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: focusedBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
            focusedBorderRadius,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.sp,
          ),
          borderRadius: BorderRadius.circular(
            focusedBorderRadius,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: focusedBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
            focusedBorderRadius,
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          color: Colors.red,
          fontSize: 15.sp,
        ),
        errorMaxLines: 2,
      ),
      validator: (content) {
        if (content!.isEmpty && (
            labelText == 'Job Title' ||
            labelText == 'Job Categor' ||
            labelText == 'Job Location' ||
            labelText == 'Working Hours' ||
            labelText == 'Job Description' ||
            labelText == 'Job Requirements' ||
            labelText == 'Expiration Period' ||
            labelText == 'Creation Time'
        )) {
          return 'Please, Fill your $labelText.';
        }
      },
      maxLines: maxLines,
      controller: controller,
    );
