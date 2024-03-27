import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/View/Components/main_button.dart';
import 'package:hirehustle/View/Screens/Login_Registration/register_screen.dart';
import 'package:rive/rive.dart';

import '../../../Helpers/CacheHelper.dart';
import '../../../ViewModel/StateManagement/Login/login_cubit.dart';
import '../../Components/Login/login_textFormField_component.dart';
import '../../Components/snack_bar.dart';
import '../HomeNavigation/home_navigation.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cacheHelper = Provider.of<CacheHelper>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocProvider(
              create: (context) => LoginCubit()..initializeAll(),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Future.delayed(
                      Duration(seconds: 2),
                      () => NavigationHelper.navigateToAndRemoveUntil(
                        context,
                        HomeNavigation(),
                      ),
                    );
                  } else if (state is LoginFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        icon: Icons.mood_bad_outlined,
                        text: state.loginFailedMessage,
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is ApiRequestFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        icon: Icons.mood_bad_outlined,
                        text: state.apiRequestErrorMessage,
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  LoginCubit loginCubit = BlocProvider.of(context);
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15.0.h),
                        height: MediaQuery.of(context).size.height / 3,
                        child: loginCubit.riveArtBoard == null
                            ? SizedBox.shrink()
                            : Rive(
                                artboard: loginCubit.riveArtBoard!,
                              ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0.sp),
                            topRight: Radius.circular(35.0.sp),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35.0),
                                  topRight: Radius.circular(35.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0.0, 10.0),
                                    blurRadius: 7.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0.h, left: 20.0.w, right: 20.0.w),
                                child: Form(
                                  key: loginCubit.formKey,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Login',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              18,
                                        ),
                                        CustomTextFormField(
                                          labelText: "Username",
                                          labelColor: Colors.white,
                                          textColor: Colors.white,
                                          cursorColor:
                                              Color.fromRGBO(207, 97, 161, 1),
                                          borderColor: Colors.transparent,
                                          borderWidth: 2.sp,
                                          borderRadius: 15.0,
                                          focusedBorderColor:
                                              Color.fromRGBO(207, 97, 161, 1),
                                          focusedBorderWidth: 2.sp,
                                          focusedBorderRadius: 15.0,
                                          onChangedFunction:
                                              loginCubit.usernameOnChanged,
                                          controller: loginCubit.username,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                        ),
                                        CustomTextFormField(
                                          labelText: "Password",
                                          labelColor: Colors.white,
                                          textColor: Colors.white,
                                          cursorColor:
                                              Color.fromRGBO(207, 97, 161, 1),
                                          borderColor: Colors.transparent,
                                          borderWidth: 2.sp,
                                          borderRadius: 15.0,
                                          focusedBorderColor:
                                              Color.fromRGBO(207, 97, 161, 1),
                                          focusedBorderWidth: 2.sp,
                                          focusedBorderRadius: 15.0,
                                          focusNode:
                                              loginCubit.passwordFocusNode,
                                          obsecureText: loginCubit.obsecure,
                                          triggerVisibilityFunction:
                                              loginCubit.triggerVisibility,
                                          suffixIcon: loginCubit.obsecure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          controller: loginCubit.password,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                'Forgot your password?',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                              // TODO: onTap: () => NavigationHelper.navigateTo(context, ForgetPasswordScreen()),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              18,
                                        ),
                                        MainButton(
                                            context: context,
                                            buttonLabel: 'Login',
                                            onPressed: () {
                                              if (loginCubit
                                                  .passwordFocusNode.hasFocus) {
                                                loginCubit.passwordFocusNode
                                                    .unfocus();
                                              }
                                              loginCubit
                                                  .validateUsernameAndPassword(cacheHelper);
                                            }),
                                        Padding(
                                          padding: EdgeInsets.only(top: 25.0.h),
                                          child: Center(
                                            child: GestureDetector(
                                              child: Text(
                                                'Don\'t have an account? Register',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                              onTap: () => NavigationHelper
                                                  .navigateToReplacement(
                                                      context,
                                                      RegistrationScreen()),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
