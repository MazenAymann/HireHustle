import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/View/Screens/HomeNavigation/home_navigation.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/Edit Job/edit_job_cubit.dart';
import '../../../constants.dart';
import '../../Components/Edit Job/edit_job.dart';
import '../../Components/Registration/secondary_button.dart';
import '../../Components/main_button.dart';
import '../../Components/snack_bar.dart';
import 'applied_applicants.dart';

class EditJob extends StatelessWidget {
  EditJob({
    required this.jobPost,
  });

  var jobPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/main_background.png',
            ),
            fit: BoxFit.fill),
      ),
      child: BlocProvider<EditJobCubit>(
        create: (context) => EditJobCubit(jobPost, context)..initializeAll(),
        child: BlocConsumer<EditJobCubit, EditJobState>(
          listener: (context, state) {
            if (state is UpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_outlined,
                  text: 'Job is updated successfully.',
                  backgroundColor: Colors.green,
                ),
              );
              NavigationHelper.navigateToAndRemoveUntil(context, HomeNavigation());
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
            EditJobCubit editJobCubit = BlocProvider.of(context);
            var jobData = editJobCubit.jobData;
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
                centerTitle: true,
                title: Text(
                  'Edit Job Post',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: Form(
                        key: editJobCubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) =>
                                  CustomJobTextFormField(
                                      labelText: jobData[index]['label'],
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
                                      controller: jobData[index]['controller'],
                                      maxLines: jobData[index]['maxLines'],
                                      enabled: jobData[index]['enabled']),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemCount: jobData.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            MainButton(
                              context: context,
                              buttonLabel: 'Cancel',
                              onPressed: () =>
                                  NavigationHelper.navigateBack(context),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            MainButton(
                              context: context,
                              buttonLabel: 'Update Job',
                              onPressed: () => editJobCubit.validateRegistration(),
                            ),
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
