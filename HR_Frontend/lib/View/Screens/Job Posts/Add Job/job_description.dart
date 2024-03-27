import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirehustle/View/Components/Job%20Posts/Add%20Job/custom_text_form_field.dart';

import '../../../../ViewModel/StateManagement/Add Job/add_job_cubit.dart';


class JobDescriptionScreen extends StatelessWidget {
  const JobDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddJobCubit, AddJobState>(
      builder: (context, state) {
        AddJobCubit addJobCubit = BlocProvider.of(context);
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          itemBuilder: (context, index) => addJobTextFormField(
              labelText: addJobCubit.jobDescriptionScreenFields[index]['labelText'],
              labelColor: Colors.white,
              textColor: Colors.white,
              cursorColor: Colors.white,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 15.sp,
              focusedBorderColor: Color.fromRGBO(208,96,163, 1.0),
              focusedBorderWidth: 2.sp,
              focusedBorderRadius: 15.sp,
              controller: addJobCubit.jobDescriptionScreenFields[index]['controller'],
            prefixIcon: addJobCubit.jobDescriptionScreenFields[index]['prefixIcon'],
          ),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: addJobCubit.jobDescriptionScreenFields.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
        );
      },
    );
  }
}