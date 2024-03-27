import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../Helpers/CacheHelper.dart';
import '../../APIs/DioHelper.dart';
import 'package:provider/provider.dart';

part 'edit_job_state.dart';

class EditJobCubit extends Cubit<EditJobState> {
  EditJobCubit(this.jobPost, this.context) : super(EditJobInitial());

  GlobalKey<FormState> formKey = new GlobalKey();

  var jobPost;
  var context;

  List jobData = [
    {
      'label': 'Job Title',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': true,
    },
    {
      'label': 'Job Category',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': false,
    },
    {
      'label': 'Job Location',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': true,
    },
    {
      'label': 'Working Hours',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': true,
    },
    {
      'label': 'Salary',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': true,
    },
    {
      'label': 'Job Description',
      'controller': TextEditingController(),
      'maxLines': 14,
      'enabled': true,
    },
    {
      'label': 'Job Requirements',
      'controller': TextEditingController(),
      'maxLines': 14,
      'enabled': true,
    },
    {
      'label': 'Overtime',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': true,
    },
    {
      'label': 'Benefits',
      'controller': TextEditingController(),
      'maxLines': 5,
      'enabled': true,
    },
    {
      'label': 'Additional Requirements',
      'controller': TextEditingController(),
      'maxLines': 8,
      'enabled': true,
    },
    {
      'label': 'Expiration Period',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': false,
    },
    {
      'label': 'Creation Time',
      'controller': TextEditingController(),
      'maxLines': 1,
      'enabled': false,
    },
  ];

  void initializeAll() {
    jobData[0]['controller'].text = jobPost['jobTitle'];
    jobData[1]['controller'].text = jobPost['jobCategory'];
    jobData[2]['controller'].text = jobPost['jobLocation'];
    jobData[3]['controller'].text = jobPost['workingHours'];
    jobData[4]['controller'].text = jobPost['salary'];
    jobData[5]['controller'].text = jobPost['jobDescription'];
    jobData[6]['controller'].text = jobPost['jobRequirements'];
    jobData[7]['controller'].text = jobPost['overtime'];
    jobData[8]['controller'].text = jobPost['benefits'];
    jobData[9]['controller'].text = jobPost['additionalRequirements'];
    jobData[10]['controller'].text = jobPost['expirationPeriod'];
    jobData[11]['controller'].text = jobPost['creationTime'];
  }

  void validateRegistration() {
    if (formKey.currentState!.validate()) {
      var applicantJson = {
        'id': jobPost['id'],
        'jobTitle': jobData[0]['controller'].text,
        'jobCategory': jobData[1]['controller'].text,
        'jobLocation': jobData[2]['controller'].text,
        'workingHours': jobData[3]['controller'].text,
        'salary': jobData[4]['controller'].text,
        'jobDescription': jobData[5]['controller'].text,
        'jobRequirements': jobData[6]['controller'].text,
        'overtime': jobData[7]['controller'].text == null ?? '',
        'benefits': jobData[8]['controller'].text,
        'additionalRequirements': jobData[9]['controller'].text,
        'expirationPeriod': jobData[10]['controller'].text,
        'creationTime': jobData[11]['controller'].text,
      };
      updateJobPost(jsonEncode(applicantJson));
    }
  }

  void updateJobPost(String jsonData) async {
    final cacheHelper = Provider.of<CacheHelper>(context, listen: false);
    var hrId = jsonDecode(cacheHelper.getCachedData(key: 'hr'))['id'];
    Response response = await DioHelper.postAPI(
        endpoint: 'hr/editJobPost/$hrId', data: jsonData);
    if (response.statusCode == 200) {
      emit(UpdateSuccess());
    } else {
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

}
