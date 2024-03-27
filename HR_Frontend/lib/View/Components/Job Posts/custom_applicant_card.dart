import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helpers/NavigationHelper.dart';
import '../../../ThemeData/app_theme.dart';
import '../../Screens/Job Posts/applicant_view.dart';
import '../../Screens/Job Posts/job_view.dart';
import '../../Screens/View CV/cv_viewer.dart';
import '../Registration/secondary_button.dart';

Widget ApplicantListCard({
  required context,
  required username,
  required email,
  required applicantIndex,
  required applicant
}) =>
    Hero(
      tag: 'jobCard$applicantIndex',
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Color.fromRGBO(208,96,163, 1.0),
                    shape: StadiumBorder(),
                    onPressed: () => NavigationHelper.navigateToWithAnimation(context, PdfViewerPage(username: applicant['username'],pdfUrl: applicant['cvPlaceholder'],)),
                    child: Text(
                      'View Cv',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Color.fromRGBO(97, 165, 207, 1.0),
                    shape: StadiumBorder(),
                    onPressed: () => NavigationHelper.navigateToWithAnimation(context, ApplicantView(applicantIndex: applicantIndex, applicant: applicant)),
                    child: Text(
                      'Details',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
