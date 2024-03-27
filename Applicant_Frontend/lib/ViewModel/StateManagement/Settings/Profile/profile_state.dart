part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class TriggerEditable extends ProfileState {}

class ImageChanged extends ProfileState {}

class TriggerRegistrationAbility extends ProfileState {}

class CvUploaded extends ProfileState {}

class UpdateSuccess extends ProfileState {
  String message;
  UpdateSuccess(this.message);
}

class UpdateFailed extends ProfileState {
  String message;
  UpdateFailed(this.message);
}

class ApiRequestFailed extends ProfileState {
  String message;
  ApiRequestFailed(this.message);
}
