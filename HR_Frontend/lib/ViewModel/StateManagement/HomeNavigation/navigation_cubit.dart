import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';

import '../../../Helpers/CacheHelper.dart';
import '../../../View/Screens/Job Posts/Add Job/add_job_post.dart';
import '../../../View/Screens/Job Posts/job_list.dart';
import '../../../View/Screens/Settings/settings.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  var index = 0;

  List screenNames = [
    'Job Posts',
    'Add Job',
    ''
  ];


  List screens = [
    JobList(),
    AddJob(),
    SettingsScreen(),
  ];

  void navigateBar(index){
    this.index = index;
    emit(NavigationChangePage());
  }
}
