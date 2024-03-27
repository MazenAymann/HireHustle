import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hirehustle/Model/Registration/hr.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:hirehustle/ViewModel/StateManagement/Login/login_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  GlobalKey<FormState> formKey = new GlobalKey();

  List fieldsData = [
    {
      'labelText': 'First Name',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Last Name',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Username',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Email',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Password',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Mobile Number',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'National Id',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Address Line',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Age',
      'controller': new TextEditingController(),
    },
  ];

  bool obsecure = true;

  void triggerVisibility() {
    obsecure = !obsecure;
    emit(TriggerVisibility());
  }

  bool get obsecureValue => obsecure;

  File? imageFile;
  var imageXFile;
  String imageLink = '';

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

  Future<String> uploadToStorage() async {
    if (imageFile != null) {
      Reference ref = FirebaseStorage.instance.ref().child('images/${Uri.file(imageFile!.path).pathSegments.last}');
      UploadTask uploadTask = ref.putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    }

    return 'No Image Provided';
  }

  bool registrationAbility = true;
  void triggerRegistrationAbility(){
    registrationAbility = !registrationAbility;
    emit(TriggerRegistrationAbility());
  }


  void validateRegistration() async {
    imageLink = await uploadToStorage();
    if (formKey.currentState!.validate()) {
      triggerRegistrationAbility();
      print(imageLink);
      HR hr = new HR(
          imageLink,
          fieldsData[0]['controller'].text,
          fieldsData[1]['controller'].text,
          fieldsData[2]['controller'].text,
          fieldsData[3]['controller'].text,
          fieldsData[4]['controller'].text,
          fieldsData[5]['controller'].text,
          fieldsData[6]['controller'].text,
          fieldsData[7]['controller'].text,
          int.parse(fieldsData[8]['controller'].text));
      String hrJson = jsonEncode(hr.toMap());
      register(hrJson);
    }
  }

  void clearAllControllers(List data) {
    imageFile = null;
    for (Map object in data) {
      object['controller'].clear();
    }
  }

  void register(String jsonData) async {
    Response response =
        await DioHelper.postAPI(endpoint: 'hr/register', data: jsonData);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);
      if (jsonResponse['status'] == 'success') {
        String successMessage = jsonResponse['data'];
        clearAllControllers(fieldsData);
        emit(RegistrationSuccess(successMessage));
        triggerRegistrationAbility();
      } else if (jsonResponse['status'] == 'failed') {
        String failureMessage = jsonResponse['message'];
        emit(RegistrationFailed(failureMessage));
        triggerRegistrationAbility();
      }
    } else {
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
      triggerRegistrationAbility();
    }
  }
}
