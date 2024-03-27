import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirehustle/View/Components/snack_bar.dart';

import '../../../../ViewModel/StateManagement/Add Job/add_job_cubit.dart';
import '../../../Components/Job Posts/Add Job/custom_text_form_field.dart';

class JobOptionalRequirements extends StatelessWidget {
  const JobOptionalRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddJobCubit, AddJobState>(
      listener: (context, state) {
        if (state is FormIsNotValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              icon: Icons.mood_bad_outlined,
              text: state.message,
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is PostStoredSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              icon: Icons.mood_outlined,
              text: state.successMessage,
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PostStoredFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              icon: Icons.mood_bad_outlined,
              text: state.failedMessage,
              backgroundColor: Colors.red,
            ),
          );
        }else if (state is ApiRequestFailed) {
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
        AddJobCubit addJobCubit = BlocProvider.of(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.sp),
                child: Text(
                  'Optional:',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                itemBuilder: (context, index) => addJobTextFormField(
                  labelText: addJobCubit.jobOptionalsScreenFields[index]
                      ['labelText'],
                  labelColor: Colors.white,
                  textColor: Colors.white,
                  cursorColor: Colors.white,
                  borderColor: Colors.transparent,
                  borderWidth: 0.0,
                  borderRadius: 15.sp,
                  focusedBorderColor: Color.fromRGBO(208, 96, 163, 1.0),
                  focusedBorderWidth: 2.sp,
                  focusedBorderRadius: 15.sp,
                  controller: addJobCubit.jobOptionalsScreenFields[index]
                      ['controller'],
                  prefixIcon: addJobCubit.jobOptionalsScreenFields[index]
                      ['prefixIcon'],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
                itemCount: addJobCubit.jobOptionalsScreenFields.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
