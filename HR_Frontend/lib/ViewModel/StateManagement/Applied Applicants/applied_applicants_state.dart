part of 'applied_applicants_cubit.dart';

@immutable
abstract class AppliedApplicantsState {}

class AppliedApplicantsInitial extends AppliedApplicantsState {}

class AppliedApplicantsFetchedSuccess extends AppliedApplicantsState {}

class AppliedApplicantsFetchedFailed extends AppliedApplicantsState {
  final String failedMessage;

  AppliedApplicantsFetchedFailed(this.failedMessage);
}

class ApiRequestFailed extends AppliedApplicantsState {
  final String apiRequestErrorMessage;

  ApiRequestFailed(this.apiRequestErrorMessage);
}


class RangeSelected extends AppliedApplicantsState {}

class RangeCanceled extends AppliedApplicantsState {}

class InterviewScheduled extends AppliedApplicantsState {
  String message;

  InterviewScheduled(this.message);
}