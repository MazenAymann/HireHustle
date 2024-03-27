import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helpers/NavigationHelper.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../constants.dart';
import '../../Screens/Job Posts/job_view.dart';
import '../Registration/secondary_button.dart';



Widget JobListCard
({
  required jobTitle,
  required jobCategory,
  required jobLocation,
  required jobCreationTime,
  required context,
  required jobPostIndex,
  required jobPostId,
  required jobPost,
})
  => MaterialButton(
    highlightColor: Colors.transparent,
      padding: EdgeInsets.zero,
      onPressed: (){
        NavigationHelper.navigateToWithAnimation(context, JobViewScreen(jobPostIndex: jobPostIndex,jobPostId: jobPostId,jobPost:jobPost));
      },
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  jobTitle,
                  style: Theme.of(context).textTheme.displayMedium
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/60,
              ),
              Row(
                children: [

                  CircleAvatar(
                    radius: 1.0,
                    backgroundColor: Colors.grey,
                  ),
                   SizedBox(
                    width: 5.0.w,
                  ),
                  Text(
                      jobCategory,
                      style: Theme.of(context).textTheme.displaySmall
                  ),
                   SizedBox(
                    width: 10.0.w,
                  ),
                  CircleAvatar(
                    radius: 1.0,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Text(
                      jobLocation,
                      style: Theme.of(context).textTheme.displaySmall
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Statics.isDarkMode? Color.fromARGB(255, 43, 44, 57) : Color.fromARGB(
                            255, 203, 214, 254),
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: MediaQuery.of(context).size.width * 0.05,
                          color: AppColorLight.subTextColor,
                        ),
                        SizedBox(
                          width: 2.0.w,
                        ),
                        Text(
                            jobCreationTime,
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: Statics.isDarkMode ? Colors.grey : Colors.white,
                            ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );