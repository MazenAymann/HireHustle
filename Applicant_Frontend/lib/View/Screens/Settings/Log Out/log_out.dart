import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Helpers/CacheHelper.dart';
import '../../../../Helpers/NavigationHelper.dart';
import '../../../../ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';
import '../../../../constants.dart';
import '../../Login_Registration/login_screen.dart';


void customShowDialog({
  required context,
}) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: Statics.isDarkMode ? [Color.fromRGBO(34, 37, 61, 1.0), Colors.purple] :[Color.fromRGBO(212, 188, 254, 1.0), Colors.cyan],
                begin: Alignment.center,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to logout?',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          NavigationHelper.navigateBack(context);
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          CacheHelper.removeCachedData(key: 'applicant').then(
                            (value) {
                              NavigationCubit cubit = BlocProvider.of(context);
                              cubit.index = 0;
                              NavigationHelper.navigateToAndRemoveUntil(
                                context,
                                LoginScreen(),
                              );
                            }
                          );
                        },
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color: Colors.white,
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
      },
    );
