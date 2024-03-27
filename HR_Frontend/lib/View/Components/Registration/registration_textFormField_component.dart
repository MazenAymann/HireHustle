import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomRegistrationTextFormField({
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
  obsecureText = false,
  triggerVisibilityFunction,
  suffixIcon,
}) =>
    TextFormField(
      obscureText: obsecureText,
      style: GoogleFonts.poppins(
        color: textColor,
      ),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(43,47,54,1.0),
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
        suffixIcon: labelText == 'Password'
            ? IconButton(
                onPressed: () => triggerVisibilityFunction(),
                icon: Icon(
                  suffixIcon,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      validator: (content) {
        if (content!.isEmpty) {
          return 'Please, Fill your $labelText.';
        }
        else if (labelText == 'Email' && !isValidEmail(content)) {
          return "Please, Provide an email with correct format.";
        } else if (labelText == 'Mobile Number' && !isValidMobileNumber(content)) {
          return "Please, Provide a number with correct format.";
        } else if (labelText == 'National Id' && !isValidNationalId(content)) {
          return "Please, Provide a national id with correct format.";
        } else if (labelText == 'Age' && !isValidAge(content)) {
          return "Sorry, Your age must be between 20 and 70.";
        }
      },
      controller: controller,
    );

bool isValidEmail(content) {
  /*
  ^ -> start with.
  [\w-\.] -> matches one or more word characters, hyphens, or dots.
  ([\w-]+\.) -> matches one or more occurrences of word characters or hyphens followed by a dot.
  [\w-]{2,4} -> matches two to four word characters or hyphens.
  $ -> end of string.
   */
  final emailRegExp = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegExp.hasMatch(content);
}

bool isValidMobileNumber(content) {
  /*
  ^ -> start with.
  [] -> anything between the brackets is allowed.
  \d -> any number between 0 and 9.
  {8} -> exactly 8 numbers.
  $ -> end of string.
   */
  final emailRegExp = RegExp(r"^01[0125]\d{8}$");
  return emailRegExp.hasMatch(content);
}

bool isValidNationalId(content){
  return content.toString().length == 14;
}

bool isValidAge(content){
  int age = int.parse(content.toString());
  return age > 20 && age < 70 ;
}