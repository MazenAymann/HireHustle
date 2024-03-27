import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../Helpers/CacheHelper.dart';
import 'package:provider/provider.dart';

import '../../../APIs/DioHelper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.hr, this.context) : super(ProfileInitial());

  BuildContext context;

  bool editable = false;

  void editProfile() {
    editable = !editable;
    emit(TriggerEditable());
  }

  var hr;

  List profileData = [
    {
      'label': 'First Name',
      'controller': TextEditingController(),
    },
    {
      'label': 'Last Name',
      'controller': TextEditingController(),
    },
    {
      'label': 'Username',
      'controller': TextEditingController(),
    },
    {
      'label': 'Email',
      'controller': TextEditingController(),
    },
    {
      'label': 'Address Line',
      'controller': TextEditingController(),
    },
    {
      'label': 'Mobile Number',
      'controller': TextEditingController(),
    },
    {
      'label': 'National Id',
      'controller': TextEditingController(),
    },
    {
      'label': 'Age',
      'controller': TextEditingController(),
    },
  ];

  void initializeAll() {
    profileData[0]['controller'].text = hr['firstName'];
    profileData[1]['controller'].text = hr['lastName'];
    profileData[2]['controller'].text = hr['username'];
    profileData[3]['controller'].text = hr['email'];
    profileData[4]['controller'].text = hr['addressLine'];
    profileData[5]['controller'].text = hr['mobileNumber'];
    profileData[6]['controller'].text = hr['nationalId'];
    profileData[7]['controller'].text = hr['age'].toString();
  }

  GlobalKey<FormState> formKey = new GlobalKey();

  File? imageFile;
  var imageXFile;
  String imageLink='';

  Future pickImage({
    fromGallery = false,
    fromCamera = false,
  }) async {
    try {
      imageXFile = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if (imageXFile == null) return;
      imageFile = File(imageXFile.path);
      emit(ImageChanged());
    } on Exception catch (exception) {
      print('Failed to pick image: $exception');
    }
  }

  void uploadToStorage() {
    FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!)
        .then((value) async {
      imageLink = await value.ref.getDownloadURL();
    }).catchError((error) {});
  }

  bool registrationAbility = true;

  void triggerRegistrationAbility() {
    registrationAbility = !registrationAbility;
    emit(TriggerRegistrationAbility());
  }

  String filePath = '';
  String cvButtonLabel = 'Upload CV';

  void validateRegistration() {
    final cacheHelper = Provider.of<CacheHelper>(context, listen: false);
    if (formKey.currentState!.validate()) {
      triggerRegistrationAbility();
      if (imageFile != null) uploadToStorage();
      var applicantJson = {
        'id': jsonDecode(cacheHelper.getCachedData(key: 'hr'))['id'],
        'profileImage': imageLink == '' ? jsonDecode(cacheHelper.getCachedData(key: 'hr'))['profileImage'] : imageLink,
        'firstName': profileData[0]['controller'].text,
        'lastName': profileData[1]['controller'].text,
        'username': profileData[2]['controller'].text,
        'email': profileData[3]['controller'].text,
        'mobileNumber': profileData[5]['controller'].text,
        'nationalId': profileData[6]['controller'].text,
        'addressLine': profileData[4]['controller'].text,
        'age': int.parse(profileData[7]['controller'].text),
        'isActivated': true,
        'password':
            jsonDecode(cacheHelper.getCachedData(key: 'hr'))['password'],
      };
      updateProfile(jsonEncode(applicantJson));
    }
  }

  void updateProfile(String jsonData) async {
    final cacheHelper = Provider.of<CacheHelper>(context, listen: false);
    Response response = await DioHelper.postAPI(
        endpoint: 'hr/editHrInfo', data: jsonData);
    if (response.statusCode == 200) {
      editProfile();
      cacheHelper.removeCachedData(key: 'hr');
      cacheHelper.saveCache(key: 'hr', value: jsonData);
      emit(UpdateSuccess('Congrats!! Profile Updated'));
      triggerRegistrationAbility();
    } else {
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
      triggerRegistrationAbility();
    }
  }
}
