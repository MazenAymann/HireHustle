import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/CacheHelper.dart';
import 'package:hirehustle/Model/Job%20Post/job_post.dart';

import '../../../View/Components/Job Posts/Add Job/custom_date_picker.dart';
import '../../../View/Components/Job Posts/Add Job/custom_time_picker.dart';
import '../../../View/Screens/Job Posts/Add Job/general_major.dart';
import '../../../View/Screens/Job Posts/Add Job/job_description.dart';
import '../../../View/Screens/Job Posts/Add Job/job_optionals.dart';
import '../../../View/Screens/Job Posts/Add Job/job_requirements.dart';
import '../../APIs/DioHelper.dart';

part 'add_job_state.dart';

class AddJobCubit extends Cubit<AddJobState> {
  AddJobCubit() : super(AddJobInitial());

  int selectedIndex = -1;

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  List itemNames = [
    'Front-End',
    'Back-End',
    'Full-Stack',
    'Artificial Intelligence',
    'Cloud Engineer',
    'Computer Hardware Engineer',
    'Game Developer',
    'Software Tester',
    'Database administrator',
    'Cyber Security',
  ];

  void changeItem(index) {
    selectedIndex = index;
    emit(ItemChanged());
  }

  int process = 0;

  List processes = [
    GeneralMajorScreen(),
    JobDescriptionScreen(),
    JobRequirementsScreen(),
    JobOptionalRequirements(),
  ];

  void nextProcess() {
    process++;
    emit(ProcessChanged());
  }

  void previousProcess() {
    process--;
    emit(ProcessChanged());
  }

  Widget whichButton({processNumber, context, hrId}) {
    switch (processNumber) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextButton(
                onPressed: () => nextProcess(),
                child: Text(
                  'Next',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(97, 165, 207, 1.0),
                ),
              ),
            ),
          ],
        );
      case 1:
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => previousProcess(),
                child: Text(
                  'Back',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(97, 165, 207, 1.0),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => nextProcess(),
                child: Text(
                  'Next',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(97, 165, 207, 1.0),
                ),
              ),
            ),
          ],
        );
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => previousProcess(),
                child: Text(
                  'Back',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(97, 165, 207, 1.0),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => addPost(hrId),
                child: Text(
                  'Finish',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(97, 165, 207, 1.0),
                ),
              ),
            ),
          ],
        );
      default:
        print('Invalid Process');
        break;
    }
    return SizedBox();
  }

  List jobDescriptionScreenFields = [
    {
      'labelText': 'Title',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.title_outlined,
    },
    {
      'labelText': 'Location',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.location_on_outlined,
    },
    {
      'labelText': 'Job Description',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.description_outlined,
    },
  ];

  List jobRequirementsScreenFields = [
    {
      'labelText': 'Expiration Period',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.alarm,
    },
    {
      'labelText': 'Working Hours',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.work_history_outlined,
    },
    {
      'labelText': 'Job Requirements',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.document_scanner_outlined,
    },
  ];

  List jobOptionalsScreenFields = [
    {
      'labelText': 'Salary',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.monetization_on_outlined,
    },
    {
      'labelText': 'Overtime',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.timelapse_outlined,
    },
    {
      'labelText': 'Benefits',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.heart_broken,
    },
    {
      'labelText': 'Additional Requirements',
      'controller': new TextEditingController(),
      'prefixIcon': Icons.post_add,
    },
  ];

  String selectedDateTime = '';

  void updateExpirationPeriod(context) async {
    final date = await showCustomDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    if (date == null) {
      selectedDateTime = '';
      jobRequirementsScreenFields[0]['controller'].text = selectedDateTime;
      emit(ExpirationPeriodChanged());
      return;
    }
    final time = await showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) {
      selectedDateTime = '';
      jobRequirementsScreenFields[0]['controller'].text = selectedDateTime;
      emit(ExpirationPeriodChanged());
      return;
    }
    final dateTime = new DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    String toBeShowed = 'Date: ${date.day}/${date.month}/${date.year} , Time: ${time.hour}:${time.minute}';
    selectedDateTime = dateTime.toIso8601String();
    jobRequirementsScreenFields[0]['controller'].text = toBeShowed;
    emit(ExpirationPeriodChanged());
  }

  void addPost(hrId) {
    if (validateForm()) {
      JobPost jobPost = new JobPost(
        itemNames[selectedIndex],
        jobDescriptionScreenFields[0]['controller'].text,
        jobDescriptionScreenFields[1]['controller'].text,
        jobDescriptionScreenFields[2]['controller'].text,
        selectedDateTime,
        jobRequirementsScreenFields[1]['controller'].text,
        jobRequirementsScreenFields[2]['controller'].text,
        jobOptionalsScreenFields[0]['controller'].text,
        jobOptionalsScreenFields[1]['controller'].text,
        jobOptionalsScreenFields[2]['controller'].text,
        jobOptionalsScreenFields[3]['controller'].text,
      );
      String jobPostJson = jsonEncode(jobPost.toMap());
      print(jobPostJson.replaceAll('\\r', ''));
      // TODO: Store Post in database.
      StorePost(jobPostJson, hrId);
    }
  }

  bool validateForm() {
    if (selectedIndex < 0 ||
        selectedIndex > itemNames.length ||
        jobDescriptionScreenFields[0]['controller'].text == '' ||
        jobDescriptionScreenFields[1]['controller'].text == '' ||
        jobDescriptionScreenFields[2]['controller'].text == '' ||
        selectedDateTime == '' ||
        jobRequirementsScreenFields[1]['controller'].text == '' ||
        jobRequirementsScreenFields[2]['controller'].text == '' ) {
      String message = 'PLease, Provide all required fields.';
      emit(FormIsNotValid(message));
      return false;
    }
    return true;
  }


  void StorePost(String jsonData, hrId) async{
    Response response = await DioHelper.postAPI(endpoint: 'hr/createJobPost/$hrId', data: jsonData);
    if (response.statusCode == 200) {
      print(response.data);
      final jsonResponse = response.data;
      if (jsonResponse['status'] == 'success') {
        String successMessage = jsonResponse['data'];
        emit(PostStoredSuccessful(successMessage));
        clearFields();
      }
      else if (jsonResponse['status'] == 'failed'){
        String failureMessage = jsonResponse['message'];
        emit(PostStoredFailed(failureMessage));
      }
    }
    else{
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

  void clearFields(){
    selectedIndex = -1;
    for(var obj in jobDescriptionScreenFields){
      obj['controller'].clear();
    }
    for(var obj in jobRequirementsScreenFields){
      obj['controller'].clear();
    }
    for(var obj in jobOptionalsScreenFields){
      obj['controller'].clear();
    }
  }
}
