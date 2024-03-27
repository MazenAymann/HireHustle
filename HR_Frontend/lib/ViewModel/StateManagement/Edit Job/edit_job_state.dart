part of 'edit_job_cubit.dart';

@immutable
abstract class EditJobState {}

class EditJobInitial extends EditJobState {}

class UpdateSuccess extends EditJobState {}

class ApiRequestFailed extends EditJobState {
  String message;

  ApiRequestFailed(this.message);
}
