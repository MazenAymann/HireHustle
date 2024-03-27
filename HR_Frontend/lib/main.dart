import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirehustle/Helpers/CacheHelper.dart';
import 'OnBoarding/on-boarding-screen.dart';
import 'splash_screen.dart';
import 'package:hirehustle/ThemeData/theme_data.dart';
import 'package:hirehustle/ViewModel/StateManagement/Registration/registration_cubit.dart';

import 'View/Screens/HomeNavigation/home_navigation.dart';
import 'View/Screens/main_screen.dart';
import 'ViewModel/StateManagement/Add Job/add_job_cubit.dart';
import 'ViewModel/StateManagement/Applied Applicants/applied_applicants_cubit.dart';
import 'ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';
import 'ViewModel/StateManagement/JobList/job_list_cubit.dart';
import 'ViewModel/StateManagement/Login/login_cubit.dart';
import 'ViewModel/StateManagement/Settings/Change Password/change_password_cubit.dart';
import 'ViewModel/StateManagement/Settings/DarkMode/dark_mode_cubit.dart';
import 'ViewModel/StateManagement/Settings/Notification/notification_screen_cubit.dart';
import 'ViewModel/StateManagement/Settings/Profile/profile_cubit.dart';
import 'ViewModel/StateManagement/Settings/settings_screen_cubit.dart';
import 'package:provider/provider.dart';


void main() async {
  // Handle Flutter Binding Error.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  // await CacheHelper.init();

  bool isLoggedIn;


  runApp(ChangeNotifierProvider(create: (BuildContext context) {
    return CacheHelper()
      ..init();
  },
      child: HireHustle()));
}

class HireHustle extends StatelessWidget {
  HireHustle({super.key});


  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    bool isLoggedIn;
    final cacheHelper = Provider.of<CacheHelper>(context);
    cacheHelper.getCachedData(key: 'hr') == null
        ? isLoggedIn = false
        : isLoggedIn = true;


    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationCubit>(
          create: (context) => RegistrationCubit(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<NotificationScreenCubit>(
          create: (context) => NotificationScreenCubit(),
        ),
        BlocProvider<DarkModeCubit>(
          create: (context) =>
          DarkModeCubit()
            ..initializeAll(),
        ),
        BlocProvider<ChangePasswordCubit>(
          create: (context) => ChangePasswordCubit(context),
        ),
        BlocProvider<AddJobCubit>(
          create: (context) => AddJobCubit(),
        ),
        BlocProvider<AppliedApplicantsCubit>(
          create: (context) => AppliedApplicantsCubit(),
        ),
        BlocProvider<JobListCubit>(
          create: (context) => JobListCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return BlocBuilder<DarkModeCubit, DarkModeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeDataLight(),
                // home: HomeNavigation(),
                home: isLoggedIn ? const SplashScreen(
                    nextScreen: HomeNavigation()) : const SplashScreen(
                    nextScreen: OnBoard()),
              );
            },
          );
        },
      ),
    );
  }
}
