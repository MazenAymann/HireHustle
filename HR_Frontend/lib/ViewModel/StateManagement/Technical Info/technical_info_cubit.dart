import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'technical_info_state.dart';

class TechnicalInfoCubit extends Cubit<TechnicalInfoState> {
  TechnicalInfoCubit() : super(TechnicalInfoInitial());

  var technicalData;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.43.245:5000/',
      receiveDataWhenStatusError: true,
    ),
  );

  void getTechnicalData({required cvLink}) async {
    print('Entered');
    var formData = FormData.fromMap({'cv_url': cvLink});

    Response response = await dio.post('extract-info', data: formData);

    if (response.statusCode == 200) {
      print(response.data);
      technicalData = response.data;
      emit(TechnicalInfoFetched());
    }
  }

  Future<Void?> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  String programmingLanguages(var data){
    if(data[0]=="N/A") {
      return "No Programming Languages Found.";
    }
    var result = StringBuffer();
    data.forEach((key, value) {
      result.writeln('$key -> $value');
    });
    return result.toString();
  }

  String spokenLanguages(var data){
    var result = StringBuffer();
    data.forEach((value) {
      result.writeln('$value');
    });
    return result.toString();
  }

  String certificates(var data){
    if(data.isEmpty || data[0]=="N/A") {
      return "No Certificates Found.";
    }
    var result = StringBuffer();
    int index = 1;
    data.forEach((value) {
      result.writeln('$index) $value');
      index++;
    });
    return result.toString();
  }

  String educations(var data){
    if(data.isEmpty || data[0]=="N/A") {
      return "No Education Data Found.";
    }
    var result = StringBuffer();
    data.forEach((value) {
      result.writeln('$value');
    });
    return result.toString();
  }

  String experience(var data ){
    if(data.isEmpty || data[0]=="N/A") {
      return "No Experience Found.";
    }
    var result = StringBuffer();
    int index = 1;
    data.forEach((value) {
      result.writeln('$index) Company -> ${value[0]}\nPosition -> ${value[1]}\nPeriod -> ${value[2]} years');
      index++;
    });
    return result.toString();
  }
}
