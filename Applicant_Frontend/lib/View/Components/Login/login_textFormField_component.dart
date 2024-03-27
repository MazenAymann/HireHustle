import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomTextFormField({
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
  onChangedFunction = null,
  obsecureText = false,
  focusNode = null,
  triggerVisibilityFunction,
  suffixIcon,
}) =>
    TextFormField(
      focusNode: focusNode,
      obscureText: obsecureText,
      style: GoogleFonts.poppins(
        color: textColor,
      ),
      cursorColor: cursorColor,
      decoration: InputDecoration(
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
        if (content!.isEmpty && labelText == 'Username') {
          return "Please, Fill your username.";
        } else if (content!.isEmpty && labelText == 'Password') {
          return "Please, Fill your password.";
        }
      },
      onChanged: (value) => onChangedFunction(value),
      controller: controller,
    );
