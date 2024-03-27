import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:provider/provider.dart';

import '../../../../Helpers/CacheHelper.dart';
import '../../../APIs/DioHelper.dart';
part 'change_password_state.dart';


class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.context) : super(ChangePasswordInitial());

  GlobalKey<FormState> formKey = new GlobalKey();

  BuildContext context;

  List changePasswordData = [
    {
      'label': 'Current password',
      'controller': new TextEditingController(),
    },
    {
      'label': 'New password',
      'controller': new TextEditingController(),
    },
    {
      'label': 'Confirm new password',
      'controller': new TextEditingController(),
    }
  ];

  static bool currentPassObsecure = true;
  static bool newPassObsecure = true;
  static bool confirmPassObsecure = true;

  bool whichObsecure(label){
    switch(label) {
      case 'Current password':
        return currentPassObsecure;
      case 'New password':
        return newPassObsecure;
      case 'Confirm new password':
        return confirmPassObsecure;
      default:
        print('Invalid Label');
        return true;
    }
  }

  void triggerVisibility(label) {
    switch(label) {
      case 'Current password':
        currentPassObsecure = !currentPassObsecure;
        emit(TriggerOldVisibility());
        break;
      case 'New password':
        newPassObsecure = !newPassObsecure;
        emit(TriggerNewVisibility());
        break;
      case 'Confirm new password':
        confirmPassObsecure = !confirmPassObsecure;
        emit(TriggerConfirmationVisibility());
        break;
      default:
        print('Invalid Label');
    }
  }

  void changePassword() {
    if (formKey.currentState!.validate()) {
      final cacheHelper = Provider.of<CacheHelper>(context, listen: false);
      String currentPassword = jsonDecode(cacheHelper.getCachedData(key: 'hr'))['password'];
      if(changePasswordData[0]['controller'].text != currentPassword){
        emit(ConfirmationPasswordFailed(
            'Sorry, Your Current Password is wrong.'));
      }
      else if (changePasswordData[1]['controller'].text !=
          changePasswordData[2]['controller'].text) {
        changePasswordData[2]['controller'].clear();
        emit(ConfirmationPasswordFailed(
            'Sorry, Confirmation password is not the same.'));
      } else if (changePasswordData[0]['controller'].text ==
          changePasswordData[1]['controller'].text) {
        changePasswordData[1]['controller'].clear();
        changePasswordData[2]['controller'].clear();
        emit(ConfirmationPasswordFailed(
            'Sorry, New password can\'t be same as the current.'));
      } else {
        // TODO: Change Password.
        int hrId = jsonDecode(cacheHelper.getCachedData(key: 'hr'))['id'];
        ChangePasswordApi(hrId: hrId);
        toDefaultValues();
      }
    }
  }

  void toDefaultValues() {
    changePasswordData[0]['controller'].clear();
    changePasswordData[1]['controller'].clear();
    changePasswordData[2]['controller'].clear();
    currentPassObsecure = true;
    newPassObsecure = true;
    confirmPassObsecure = true;
  }

  void ChangePasswordApi({hrId}) async {
    String newPass = changePasswordData[2]['controller'].text;
    Response response = await DioHelper.postAPI(endpoint: 'hr/changeHrPassword/$hrId', data: {'password':newPass});
    if (response.statusCode == 200) {
      updateCache(newPass);
      String passwordChangedMessage = 'Congrats!! Your password changed.';
      emit(PasswordChanged(passwordChangedMessage));
    }
    else{
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestError(apiRequestErrorMessage));
    }
  }

  void updateCache(String newPass){
    final cacheHelper = Provider.of<CacheHelper>(context, listen: false);
    var applicant = jsonDecode(cacheHelper.getCachedData(key: 'hr'));
    applicant['password'] = newPass;
    cacheHelper.removeCachedData(key: 'hr');
    cacheHelper.saveCache(key: 'hr', value: jsonEncode(applicant));
  }
}
