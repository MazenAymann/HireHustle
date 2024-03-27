import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../APIs/DioHelper.dart';
import '../Applied Applicants/applied_applicants_cubit.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit() : super(RecommendationsInitial());

  var sortedApplicants;
  late var recommendationsResult = {};

  Dio dio2 = Dio(BaseOptions(
    baseUrl: 'http://192.168.43.245:5000/',
    receiveDataWhenStatusError: true,
    // connectTimeout: ,
    // receiveTimeout: ,
  ));

  void makeRecommendationsByTextSimilarity(
      var jobPostId,
      var appliedApplicants
      ) async {
    String? jobData = await getJobData(jobPostId);
    var jsonData = {
      "job_description" : jobData,
      "cvs": getApplicantsCVs(appliedApplicants)
    };

    // print(getApplicantsCVs(appliedApplicants));
    try {
      final response = await dio2.post(
          'text-similarity',
          data: jsonData,
          options: Options(
              contentType: 'application/json'
          )
      );
      if (response.statusCode == 200) {
        print(response.data);
        recommendationsResult = response.data;
        handleRecommendationsSorting(appliedApplicants);
      }
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }
  void makeRecommendationsBySemanticSimilarity(
      var jobPostId,
      var appliedApplicants
      ) async {
    String? jobData = await getJobData(jobPostId);
    var jsonData = {
      "job_description" : jobData,
      "cvs": getApplicantsCVs(appliedApplicants)
    };

    // print(getApplicantsCVs(appliedApplicants));
    try {
      final response = await dio2.post(
          'semantic-similarity',
          data: jsonData,
          options: Options(
              contentType: 'application/json'
          )
      );
      if (response.statusCode == 200) {
        print(response.data);
        recommendationsResult = response.data;
        handleRecommendationsSorting(appliedApplicants);
      }
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }


  Future<String?> getJobData(jobPostId) async{
    Response response = await DioHelper.getAPI(endpoint: '/hr/getJobPostById/$jobPostId');
    if (response.statusCode == 200) {
      var jobJson = response.data['data'];
      return jobJson['jobDescription'] + jobJson['jobRequirements'];
    }
    else
      return "null";
  }

  Map<String, String> getApplicantsCVs(appliedApplicants){
    Map<String, String> applicantsMap = {};
    for(int i = 0; i < appliedApplicants.length; i++){
      applicantsMap[appliedApplicants[i]['id'].toString()] = appliedApplicants[i]['cvPlaceholder'];
    }
    print(applicantsMap);
    return applicantsMap;
  }

  void handleRecommendationsSorting(appliedApplicants){
    var sortedRecommendations = sortMapByValuesDescending(recommendationsResult);

    List<Map<String, dynamic>> sortedList = List.from(appliedApplicants);

    sortedList.sort((a, b) {
      String idA = a['id'].toString();
      String idB = b['id'].toString();

      double recommendationA = sortedRecommendations[idA] ?? 0;
      double recommendationB = sortedRecommendations[idB] ?? 0;

      return recommendationB.compareTo(recommendationA);
    });
    sortedApplicants = sortedList;
    print(sortedApplicants);
    emit(RecommendationsFinished());
  }

  Map<dynamic, dynamic> sortMapByValuesDescending(Map<dynamic, dynamic> map) {
    List<MapEntry<dynamic, dynamic>> sortedEntries = map.entries.toList();

    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEntries);
  }

  faceIcon(rate) {
    if (rate >= 0 && rate<= 25) {
      return Icons.sentiment_very_dissatisfied_rounded;
    }
    if (rate >= 25 && rate<= 50) {
      return Icons.sentiment_neutral;
    }
    if (rate >= 50 && rate<= 75) {
      return Icons.sentiment_satisfied;
    }
    if (rate >= 75 && rate<= 100) {
      return Icons.sentiment_very_satisfied_rounded;
    }
  }

  faceColor(rate) {
    if (rate >= 0 && rate<= 25) {
      return Colors.red;
    }
    if (rate >= 25 && rate<= 50) {
      return Colors.amber;
    }
    if (rate >= 50 && rate<= 75) {
      return Colors.green;
    }
    if (rate >= 75 && rate<= 100) {
      return Colors.greenAccent;
    }
  }




}
