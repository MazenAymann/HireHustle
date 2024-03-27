import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';
import '../../../constants.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              Statics.background()
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          NavigationCubit navigationCubit = BlocProvider.of(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                navigationCubit.screenNames[navigationCubit.index],
                style: GoogleFonts.poppins(fontSize: 20.sp, color: Statics.isDarkMode? Colors.white : Colors.black),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: navigationCubit.screens[navigationCubit.index],
                ),
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              height: 50.h,
              backgroundColor: Colors.transparent,
              color: Statics.isDarkMode ? Color.fromRGBO(36, 36, 61, 1.0) : Color.fromRGBO(188,188,255, 1.0),
              animationDuration: Duration(milliseconds: 300),
              onTap: (index) => navigationCubit.navigateBar(index),
              items: [
                Icon(
                  Icons.work_history_outlined,
                  color: Statics.isDarkMode ? Colors.white : Colors.black,
                ),
                Icon(
                  Icons.settings,
                  color: Statics.isDarkMode ? Colors.white : Colors.black,
                ),
                // Icon(
                //   Icons.dark_mode,
                //   color: Statics.isDarkMode ? Colors.white : Colors.black,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
