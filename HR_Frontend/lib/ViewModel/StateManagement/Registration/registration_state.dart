part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class TriggerVisibility extends RegistrationState {}

class ImageChanged extends RegistrationState {}
class RegistrationSuccess extends RegistrationState {
  final registrationSuccessMessage;

  RegistrationSuccess(this.registrationSuccessMessage);
}

class RegistrationFailed extends RegistrationState {
  final registrationFailedMessage;

  RegistrationFailed(this.registrationFailedMessage);
}

class ApiRequestFailed extends RegistrationState {
  final apiRequestErrorMessage;

  ApiRequestFailed(this.apiRequestErrorMessage);
}

class TriggerRegistrationAbility extends RegistrationState {}


