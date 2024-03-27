import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/ViewModel/StateManagement/Settings/DarkMode/dark_mode_cubit.dart';
import 'package:hirehustle/constants.dart';

import '../../../ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.darkModeBackground),
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
                style: GoogleFonts.poppins(fontSize: 20.sp),
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
              color: Color.fromRGBO(36, 36, 61, 1.0),
              animationDuration: Duration(milliseconds: 300),
              onTap: (index) => navigationCubit.navigateBar(index),
              items: [
                Icon(
                  Icons.work_history_outlined,
                  color: Colors.white,
                ),
                Icon(
                  Icons.add_circle_outline_outlined,
                  color: Colors.white,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
