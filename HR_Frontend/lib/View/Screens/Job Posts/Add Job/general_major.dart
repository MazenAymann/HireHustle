import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ThemeData/app_theme.dart';
import '../../../../ViewModel/StateManagement/Add Job/add_job_cubit.dart';

class GeneralMajorScreen extends StatelessWidget {
  GeneralMajorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddJobCubit, AddJobState>(
      builder: (context, state) {
        AddJobCubit addJobCubit = BlocProvider.of(context);
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 0.8,
          physics: BouncingScrollPhysics(),
          children: List.generate(
            addJobCubit.itemNames.length,
            (index) {
              return GestureDetector(
                onTap: () => addJobCubit.changeItem(index),
                child: Container(
                  margin: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: addJobCubit.selectedIndex == index
                        ? AppColorLight.gridSelectedColor
                        : AppColorLight.gridUnselectedColor,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/images/${addJobCubit.itemNames[index]}.png',
                          ),
                          height: MediaQuery.of(context).size.width*0.3,
                          width: MediaQuery.of(context).size.width*0.3,
                          fit: BoxFit.cover,
                          color: Colors.white,
                        ),
                        SizedBox(height:15.h),
                        Text(
                          addJobCubit.itemNames[index],
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
