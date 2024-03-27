import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'job_list_state.dart';

class JobListCubit extends Cubit<JobListState> {
  JobListCubit() : super(JobListInitial());

  static JobListCubit get(context) => BlocProvider.of(context);

  var jobList;

  void fetchAllValidJobPosts({required int hrId}) async {
    Response response = await DioHelper.getAPI(
      endpoint: 'hr/getHrJobPosts/$hrId',
    );
    if (response.statusCode == 200) {
      jobList = response.data;
      emit(JobFetchedSuccess());
    } else {
      String apiRequestErrorMessage = 'Sorry, there is a server error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

  String convertDateFormat(inputDate) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Create a formatter to convert the date to the desired format
    DateFormat formatter = DateFormat('d/M/yyyy');

    // Format the date using the formatter
    String formattedDate = formatter.format(dateTime);

    // Return the formatted date
    return formattedDate;
  }

  String convertTimeFormat(String inputTime) {
    // Parse the input time string
    DateTime dateTime = DateTime.parse(inputTime);

    // Create a formatter to convert the time to the desired format
    DateFormat formatter = DateFormat('HH:mm');

    // Format the time using the formatter
    String formattedTime = formatter.format(dateTime);

    // Return the formatted time
    return formattedTime;
  }

  String convertDateTimeFormat(String inputDateTime){
    return 'Date: ${convertDateFormat(inputDateTime)} Time: ${convertTimeFormat(inputDateTime)}';
  }

  void deleteJobPost({required jobPostId}) async {
    Response response = await DioHelper.deleteAPI(endpoint: 'hr/deleteJobPost/$jobPostId');
    if(response.statusCode == 200){
      emit(JobPostDeleted('Job post deleted successfully.'));

    }
    else{
      emit(ApiRequestFailed('Sorry, there is a maintenance in the server..'));
    }
  }


}
