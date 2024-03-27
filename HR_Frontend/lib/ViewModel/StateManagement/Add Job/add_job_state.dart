part of 'add_job_cubit.dart';

@immutable
abstract class AddJobState {}

class AddJobInitial extends AddJobState {}

class ItemChanged extends AddJobState {}

class ProcessChanged extends AddJobState {}

class FormIsNotValid extends AddJobState {
  String message;

  FormIsNotValid(this.message);
}

class ExpirationPeriodChanged extends AddJobState {}

class PostStoredSuccessful extends AddJobState {
  String successMessage;

  PostStoredSuccessful(this.successMessage);
}

class PostStoredFailed extends AddJobState {
  String failedMessage;

  PostStoredFailed(this.failedMessage);
}

class ApiRequestFailed extends AddJobState {
  String apiRequestErrorMessage;

  ApiRequestFailed(this.apiRequestErrorMessage);
}
