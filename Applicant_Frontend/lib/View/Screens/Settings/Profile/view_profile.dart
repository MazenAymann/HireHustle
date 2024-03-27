import 'package:Applicant_HireHustle/Helpers/NavigationHelper.dart';
import 'package:Applicant_HireHustle/View/Screens/Settings/Profile/view_cv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../ThemeData/app_theme.dart';
import '../../../../ViewModel/StateManagement/Settings/Profile/profile_cubit.dart';
import '../../../../constants.dart';
import '../../../Components/Profile/custom_profile_Field.dart';
import '../../../Components/Registration/registration_textFormField_component.dart';
import '../../../Components/Registration/secondary_button.dart';
import '../../../Components/main_button.dart';
import '../../../Components/snack_bar.dart';

class ViewProfile extends StatelessWidget {
  ViewProfile({super.key, this.applicant});

  var applicant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocProvider(
        create: (context) => ProfileCubit(applicant)..initializeAll(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_outlined,
                  text: state.message,
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ApiRequestFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_bad_outlined,
                  text: state.message,
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            ProfileCubit profileCubit = BlocProvider.of(context);
            var profileData = profileCubit.profileData;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Statics.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      NavigationHelper.navigateBack(context);
                    }),
                actions: [
                  !profileCubit.editable
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.03),
                          child: PopupMenuButton(
                            splashRadius: 0,
                            color: AppColorLight.contactUsTextFieldColor,
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                onTap: () => profileCubit.editProfile(),
                                value: 'edit',
                                child: Text(
                                  'Edit Profile',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ],
                            child: Icon(
                              Icons.edit,
                              color: Statics.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: MediaQuery.of(context).size.height * 0.1,
                        backgroundImage: applicant['profileImage'] == '' ||
                                applicant['profileImage'] == null
                            ? AssetImage(
                                AppColorLight.darkModeImage,
                              )
                            : NetworkImage(applicant['profileImage'])
                                as ImageProvider,
                      ),
                    ),
                    profileCubit.editable
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SecondaryButton(
                                  buttonLabel: 'Upload Image',
                                  onPressed: () => profileCubit.pickImage(
                                    fromGallery: true,
                                  ),
                                ),
                                SecondaryButton(
                                  buttonLabel: 'Take Image',
                                  onPressed: () => profileCubit.pickImage(
                                    fromCamera: true,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    Container(
                      color: Colors.transparent,
                      child: Form(
                        key: profileCubit.formKey,
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
                                    child: CustomProfileTextFormField(
                                      labelText: profileData[0]['label'],
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
                                      controller: profileData[0]['controller'],
                                      enabled: profileCubit.editable,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 30,
                                  ),
                                  Expanded(
                                    child: CustomProfileTextFormField(
                                      labelText: profileData[1]['label'],
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
                                      controller: profileData[1]['controller'],
                                      enabled: profileCubit.editable,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) =>
                                  CustomProfileTextFormField(
                                labelText: profileData[index + 2]['label'],
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
                                controller: profileData[index + 2]
                                    ['controller'],
                                enabled: profileCubit.editable,
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemCount: profileData.length - 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            SizedBox(height: 10.h),
                            profileCubit.editable
                                ? SecondaryButton(
                                    buttonLabel: 'Update CV',
                                    onPressed: () => profileCubit.uploadCV())
                                : SecondaryButton(
                                    buttonLabel: 'Show CV',
                                    onPressed: () {
                                      if (applicant['cvPlaceholder'] != '' &&
                                          applicant['cvPlaceholder'] != null) {
                                        NavigationHelper
                                            .navigateToWithAnimation(
                                                context,
                                                PdfViewerPage(
                                                  pdfUrl: applicant[
                                                      'cvPlaceholder'],
                                                  username:
                                                      applicant['username'],
                                                ));
                                      }
                                    }),
                            profileCubit.editable
                                ? SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 25,
                                  )
                                : SizedBox(),
                            profileCubit.editable
                                ? MainButton(
                                    context: context,
                                    buttonLabel: 'Cancel',
                                    onPressed: () => profileCubit.editProfile(),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            profileCubit.editable
                                ? MainButton(
                                    context: context,
                                    buttonLabel: 'Update Profile',
                                    onPressed: () {
                                      if (profileCubit.registrationAbility) {
                                        profileCubit.validateRegistration();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          customSnackBar(
                                              icon: Icons.mood_bad_outlined,
                                              text:
                                                  'Please, wait until the request proceed.',
                                              backgroundColor: Colors.teal),
                                        );
                                      }
                                    },
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
