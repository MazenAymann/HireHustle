import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:meta/meta.dart';

import '../../../View/Components/Job Posts/Add Job/custom_time_picker.dart';

part 'applied_applicants_state.dart';

class AppliedApplicantsCubit extends Cubit<AppliedApplicantsState> {
  AppliedApplicantsCubit() : super(AppliedApplicantsInitial());

  var appliedApplicants;

  void getApplicantsById(jobPostId) async {
    Response response =
        await DioHelper.getAPI(endpoint: 'hr/getAllApplicants/$jobPostId');
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse['status'] == 'success') {
        appliedApplicants = jsonResponse['data'];
        emit(AppliedApplicantsFetchedSuccess());
      } else if (jsonResponse['status'] == 'failed') {
        String FailedMessage = jsonResponse['message'];
        emit(AppliedApplicantsFetchedFailed(FailedMessage));
      }
    } else {
      String apiRequestErrorMessage = 'Sorry, there is a server error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

  DateTime? startDate;
  DateTime? endDate;
  List<DateTime> dateRange = [];
  List<String> selectedDateTimeSlots = [];

 void onApply({startDate, endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;
    listAllDateRange();
    print('$dateRange');
  }

  void onCancel() {
    startDate = null;
    endDate = null;
    dateRange = [];
    emit(RangeSelected());
  }

  void listAllDateRange() {
    DateTime? date = startDate;
    while (date!.isBefore(endDate!) || date.isAtSameMomentAs(endDate!)) {
      dateRange.add(date);
      date = date.add(Duration(days: 1));
    }
  }

  Future<void> timePickerForDates(context, username, email) async {
    selectedDateTimeSlots = []; // Clear the list before adding new values

    for (var element in dateRange) {
      var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time == null) {
        // Handle the case where the user cancels the time picker
        emit(RangeSelected());
        dateRange = [];
        return;
      }

      var dateTime = DateTime(
        element.year,
        element.month,
        element.day,
        time.hour,
        time.minute,
      );

      selectedDateTimeSlots.add(dateTime.toString()); // Store the selected DateTime
    }
    print(selectedDateTimeSlots);

    await ScheduleInterview(email: email,username: username);
    dateRange = [];
  }

  var responseMessage;

  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.43.245:5000/',
    receiveDataWhenStatusError: true,
  ));

  Future<void> ScheduleInterview({required String username,
    required String email}
      ) async {
    var jsonData = {
        "applicant_name": username,
        "applicant_email": email,
        "available_slots": selectedDateTimeSlots
    };

    print(jsonData);
    try {
      final response = await dio.post(
          'send-confirmation',
          data: jsonData,
          options: Options(
              contentType: 'application/json'
          )
      );
      if (response.statusCode == 200) {
        print(response.data);
        responseMessage = response.data['interview_time'];
        emit(InterviewScheduled("Congrats! Interview is scheduled at $responseMessage"));
      }
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }

}
