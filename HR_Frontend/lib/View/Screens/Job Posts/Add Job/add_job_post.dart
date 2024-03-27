import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Helpers/CacheHelper.dart';
import '../../../../ThemeData/app_theme.dart';
import '../../../../ViewModel/StateManagement/Add Job/add_job_cubit.dart';
import 'package:provider/provider.dart';

class AddJob extends StatelessWidget {
  const AddJob({super.key});

  @override
  Widget build(BuildContext context) {
    final cacheHelper = Provider.of<CacheHelper>(context);
    var hrId = jsonDecode(cacheHelper.getCachedData(key: 'hr'))['id'];
    return BlocConsumer<AddJobCubit, AddJobState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AddJobCubit addJobCubit = BlocProvider.of(context);
        return Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                    color: Colors.transparent,
                    child: addJobCubit.processes[addJobCubit.process]),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: addJobCubit.whichButton(
                  processNumber: addJobCubit.process,
                  context: context,
                  hrId: hrId
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
