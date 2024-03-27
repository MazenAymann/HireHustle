import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget addJobTextFormField({
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
  required prefixIcon,
  showDateAndTime,
}) =>
    TextFormField(
      maxLines: labelText == 'Job Description' ||
              labelText == 'Job Requirements' ||
              labelText == 'Additional Requirements'
          ? 15
          : labelText == 'Benefits'
              ? 4
              : 1,
      style: GoogleFonts.poppins(
        color: textColor,
      ),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        // alignLabelWithHint:
        //     labelText == 'Job Description' || labelText == 'Job Requirements' || labelText == 'Additional Requirements' || labelText == 'Benefits'
        //         ? true
        //         : false,
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
        prefixIcon: Icon(
          prefixIcon,
          color: Color.fromRGBO(97, 165, 207, 1.0),
        ),
      ),
      // enabled: labelText == 'Expiration Period' ? false : true,
      onTap: labelText == 'Expiration Period' ? showDateAndTime : null,
      validator: (content) {
        if (content!.isEmpty &&
            (labelText == 'Title' ||
                labelText == 'Location' ||
                labelText == 'Job Description' ||
                labelText == 'Expiration Period' ||
                labelText == 'Working Hours' ||
                labelText == 'Job Requirements')) {
          return "Please, Fill your $labelText.";
        }
      },
      controller: controller,
    );
