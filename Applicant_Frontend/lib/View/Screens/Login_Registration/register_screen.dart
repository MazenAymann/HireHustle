import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helpers/NavigationHelper.dart';
import '../../../ViewModel/StateManagement/Registration/registration_cubit.dart';
import '../../../constants.dart';
import '../../Components/Registration/oval_photo_placeholder.dart';
import '../../Components/Registration/registration_textFormField_component.dart';
import '../../Components/Registration/secondary_button.dart';
import '../../Components/main_button.dart';
import '../../Components/snack_bar.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocConsumer<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    icon: Icons.mood_outlined,
                    text: state.registrationSuccessMessage,
                    backgroundColor: Colors.green,
                  ),
                );
                Future.delayed(
                  Duration(seconds: 2),
                  () => NavigationHelper.navigateToReplacement(
                    context,
                    LoginScreen(),
                  ),
                );
              } else if (state is RegistrationFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    icon: Icons.mood_bad_outlined,
                    text: state.registrationFailedMessage,
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
              RegistrationCubit registrationCubit = BlocProvider.of(context);
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    padding: EdgeInsets.only(top: 30.h),
                    child: Center(
                      child: OvalPhotoPlaceholder(
                        context: context,
                        file: registrationCubit.imageFile,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SecondaryButton(
                          buttonLabel: 'Upload Image',
                          onPressed: () => registrationCubit.pickImage(
                            fromGallery: true,
                          ),
                        ),
                        SecondaryButton(
                          buttonLabel: 'Take Image',
                          onPressed: () => registrationCubit.pickImage(
                            fromCamera: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Form(
                      key: registrationCubit.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomRegistrationTextFormField(
                                    labelText: registrationCubit.fieldsData[0]
                                        ['labelText'],
                                    labelColor: Colors.white,
                                    textColor: Colors.white,
                                    cursorColor: Colors.white,
                                    borderColor: Colors.transparent,
                                    borderWidth: 2.sp,
                                    borderRadius: 10.sp,
                                    focusedBorderColor:
                                        Color.fromRGBO(22, 208, 227, 1),
                                    focusedBorderWidth: 2.sp,
                                    focusedBorderRadius: 10.sp,
                                    controller: registrationCubit.fieldsData[0]
                                        ['controller'],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 30,
                                ),
                                Expanded(
                                  child: CustomRegistrationTextFormField(
                                    labelText: registrationCubit.fieldsData[1]
                                        ['labelText'],
                                    labelColor: Colors.white,
                                    textColor: Colors.white,
                                    cursorColor: Colors.white,
                                    borderColor: Colors.transparent,
                                    borderWidth: 2.sp,
                                    borderRadius: 10.sp,
                                    focusedBorderColor:
                                        Color.fromRGBO(22, 208, 227, 1),
                                    focusedBorderWidth: 2.sp,
                                    focusedBorderRadius: 10.sp,
                                    onChangedFunction: registrationCubit
                                        .fieldsData[1]['onChanged'],
                                    controller: registrationCubit.fieldsData[1]
                                        ['controller'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            itemBuilder: (context, index) =>
                                CustomRegistrationTextFormField(
                              labelText: registrationCubit.fieldsData[index + 2]
                                  ['labelText'],
                              labelColor: Colors.white,
                              textColor: Colors.white,
                              cursorColor: Colors.white,
                              borderColor: Colors.transparent,
                              borderWidth: 2.sp,
                              borderRadius: 10.sp,
                              focusedBorderColor:
                                  Color.fromRGBO(22, 208, 227, 1),
                              focusedBorderWidth: 2.sp,
                              focusedBorderRadius: 10.sp,
                              onChangedFunction: registrationCubit
                                  .fieldsData[index + 2]['onChanged'],
                              controller: registrationCubit
                                  .fieldsData[index + 2]['controller'],
                              suffixIcon:
                                  registrationCubit.fieldsData[index + 2]
                                                  ['labelText'] ==
                                              'Password' &&
                                          registrationCubit.obsecureValue
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                              triggerVisibilityFunction:
                                  registrationCubit.triggerVisibility,
                              obsecureText: registrationCubit
                                          .fieldsData[index + 2]['labelText'] ==
                                      'Password'
                                  ? registrationCubit.obsecureValue
                                  : false,
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemCount: registrationCubit.fieldsData.length - 2,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            physics: NeverScrollableScrollPhysics(),
                          ),
                          SizedBox(height: 10.h),
                          SecondaryButton(
                            buttonLabel: registrationCubit.cvButtonLabel,
                            onPressed: () => registrationCubit.uploadCV(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          MainButton(
                            context: context,
                            buttonLabel: 'Register',
                            onPressed: () {
                              if (registrationCubit.registrationAbility) {
                                registrationCubit.validateRegistration();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      icon: Icons.mood_bad_outlined,
                                      text:
                                      'Please, wait until the request proceed.',
                                      backgroundColor: Colors.teal),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0.h),
                            child: Center(
                              child: GestureDetector(
                                child: Text(
                                  'Already have an account? Login',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                onTap: () {
                                  NavigationHelper.navigateToReplacement(
                                    context,
                                    LoginScreen(),
                                  );
                                  registrationCubit.clearAllControllers(registrationCubit.fieldsData);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
