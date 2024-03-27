
import 'dart:convert';
import 'dart:io';

import 'package:Applicant_HireHustle/Helpers/CacheHelper.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../Model/Registration/applicant.dart';
import '../../../APIs/DioHelper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.applicant) : super(ProfileInitial());

  bool editable = false;

  void editProfile(){
    editable = !editable;
    emit(TriggerEditable());
  }

  var applicant;

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

  void initializeAll(){
    profileData[0]['controller'].text = applicant['firstName'];
    profileData[1]['controller'].text = applicant['lastName'];
    profileData[2]['controller'].text = applicant['username'];
    profileData[3]['controller'].text = applicant['email'];
    profileData[4]['controller'].text = applicant['addressLine'];
    profileData[5]['controller'].text = applicant['mobileNumber'];
    profileData[6]['controller'].text = applicant['nationalId'];
    profileData[7]['controller'].text = applicant['age'].toString();
  }

  GlobalKey<FormState> formKey = new GlobalKey();

  File? imageFile;
  var imageXFile;
  String imageLink = jsonDecode(CacheHelper.getCachedData(key: 'applicant'))['profileImage'];

  Future pickImage({
    fromGallery = false,
    fromCamera = false,
  }) async {
    try {
      imageXFile = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if(imageXFile == null) return;
      imageFile = File(imageXFile.path);
      emit(ImageChanged());

    } on Exception catch (exception) {
      print('Failed to pick image: $exception');
    }
  }

  Future<void> uploadToStorage() async {
    FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!)
        .then((value) async {
      imageLink = await value.ref.getDownloadURL();
    })
        .catchError((error) {});
  }


  bool registrationAbility = true;
  void triggerRegistrationAbility(){
    registrationAbility = !registrationAbility;
    emit(TriggerRegistrationAbility());
  }

  String filePath = '';
  String cvButtonLabel = 'Upload CV';
  late String cvLink;

  Future<void> uploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      filePath = result.files.single.path!;
      FirebaseStorage.instance
          .ref()
          .child('cvs/${Uri.file(filePath).pathSegments.last}')
          .putFile(new File(filePath))
          .then((value) async {
        cvLink = await value.ref.getDownloadURL();
      })
          .catchError((error) {});
      cvButtonLabel = 'Uploaded!';
      emit(CvUploaded());
    }
  }


  void validateRegistration() {
    if (imageFile != null)
      uploadToStorage();
    if (formKey.currentState!.validate()) {
      triggerRegistrationAbility();
      var applicantJson = {
        'id': jsonDecode(CacheHelper.getCachedData(key: 'applicant'))['id'],
        'profileImage': imageLink,
        'firstName': profileData[0]['controller'].text,
        'lastName': profileData[1]['controller'].text,
        'username': profileData[2]['controller'].text,
        'email': profileData[3]['controller'].text,
        'mobileNumber': profileData[5]['controller'].text,
        'nationalId': profileData[6]['controller'].text,
        'addressLine': profileData[4]['controller'].text,
        'age': int.parse(profileData[7]['controller'].text),
        'cvPlaceholder': filePath == '' ? jsonDecode(CacheHelper.getCachedData(key: 'applicant'))['cvPlaceholder'] : cvLink,
        'isActivated': true,
        'password': jsonDecode(CacheHelper.getCachedData(key: 'applicant'))['password'],
      };
      updateProfile(jsonEncode(applicantJson));
    }
  }

  void updateProfile(String jsonData) async{
    Response response = await DioHelper.postAPI(endpoint: 'applicant/editApplicantInfo', data: jsonData);
    if (response.statusCode == 200) {
        editProfile();
        CacheHelper.removeCachedData(key: 'applicant');
        CacheHelper.saveCache(key: 'applicant', value: jsonData);
        emit(UpdateSuccess('Congrats!! Profile Updated'));
        triggerRegistrationAbility();
    }
    else{
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
      triggerRegistrationAbility();
    }
  }
}
