import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/job_screen_button.dart';
import 'package:hire_hustle/ApplicationScreen/modules/job_list_screen/JobList.dart';
import 'package:hire_hustle/ApplicationScreen/modules/settings_screen/setting_screen.dart';

import '../../ApplicationScreen/modules/add_job/add_job_screen.dart';
import '../../global/theme/app_color/app_color_light.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  var index = 0;

  List screens = [
    const JobList(),
    const JobScreenButton(),
    const SettingsScreen(),
  ];

  void navigateBar(index){
    this.index = index;
    emit(NavigationChangePage());
  }
}

