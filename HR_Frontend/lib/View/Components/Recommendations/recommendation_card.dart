import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Helpers/NavigationHelper.dart';
import '../../Screens/Recommendations/recommendation_applicant.dart';
import '../../Screens/View CV/cv_viewer.dart';

Widget RecommendationListCard({
  required context,
  required username,
  required applicantIndex,
  required rate,
  required sortedApplicants,
  required faceIcon,
  required faceColor,
}) =>
    Hero(
      tag: 'recommendationCard$applicantIndex',
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              Row(
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
                      Icon(
                        faceIcon,
                        color: faceColor,
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Text(
                        '$rate%',
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Color.fromRGBO(208, 96, 163, 1.0),
                    shape: StadiumBorder(),
                    onPressed: () => NavigationHelper.navigateToWithAnimation(
                      context,
                      PdfViewerPage(
                        username: username,
                        pdfUrl: sortedApplicants[applicantIndex]
                            ['cvPlaceholder'],
                      ),
                    ),
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
                    onPressed: () => NavigationHelper.navigateToWithAnimation(
                      context,
                      RecommendedApplicantView(
                          applicantIndex: applicantIndex,
                          sortedApplicants: sortedApplicants),
                    ),
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
