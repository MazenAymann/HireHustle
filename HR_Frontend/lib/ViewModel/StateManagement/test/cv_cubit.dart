import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'cv_state.dart';

class CvCubit extends Cubit<CvState> {
  CvCubit() : super(CvInitial());

  static late String filePath;

  void showCV() {}

  static Future<void> uploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      filePath = result.files.single.path!;
      print(filePath);
    }
  }

  static Future<String> encodeCVFileToBase64(String filePath) async {
    File file = File(filePath);
    List<int> bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

}
