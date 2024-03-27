part of 'job_list_cubit.dart';

@immutable
abstract class JobListState {}

class JobListInitial extends JobListState {}

class JobFetchedSuccess extends JobListState {}

class JobFetchFailed extends JobListState {
  final FailedMessage;

  JobFetchFailed(this.FailedMessage);
}

class ApiRequestFailed extends JobListState {
  final apiRequestErrorMessage;

  ApiRequestFailed(this.apiRequestErrorMessage);
}

class ApplyFailed extends JobListState {}

class ApplySucceeded extends JobListState {}
