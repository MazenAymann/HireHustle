import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ViewModel/StateManagement/Add Job/add_job_cubit.dart';
import '../../../Components/Job Posts/Add Job/custom_text_form_field.dart';

class JobRequirementsScreen extends StatelessWidget {
  const JobRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddJobCubit, AddJobState>(
      builder: (context, state) {
        AddJobCubit addJobCubit = BlocProvider.of(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // TextButton(
              //   onPressed: () async {
              //     final date = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2023),
              //       lastDate: DateTime(2024),
              //
              //     );
              //     if (date == null) {
              //       return;
              //     }
              //     print(date);
              //     addJobCubit.selectedDateTime = date.toString();
              //     addJobCubit.updateExpirationPeriod();
              //   },
              //   child: Text(
              //     'show date time picker (Arabic)',
              //     style: TextStyle(color: Colors.blue),
              //   ),
              // ),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                itemBuilder: (context, index) => addJobTextFormField(
                  labelText: addJobCubit.jobRequirementsScreenFields[index]
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
                  controller: addJobCubit.jobRequirementsScreenFields[index]
                      ['controller'],
                  prefixIcon: addJobCubit.jobRequirementsScreenFields[index]
                      ['prefixIcon'],
                  showDateAndTime: () => addJobCubit.updateExpirationPeriod(context),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
                itemCount: addJobCubit.jobRequirementsScreenFields.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        );
        ;
      },
    );
  }
}
