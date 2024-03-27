import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ThemeData/app_theme.dart';
import '../../../../constants.dart';

Widget customField({
  required context,
  required title,
  required fieldLeadingIcon,
  required fieldContent,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
              color: AppColorLight.contactUsTextFieldColor,
              borderRadius: BorderRadius.circular(10),),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 100,
              ),
              Icon(fieldLeadingIcon),
              SizedBox(
                width: MediaQuery.of(context).size.height / 100,
              ),
              Text(
                fieldContent,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.white,

                ),
              )
            ],
          ),
        ),
      ],
    );
