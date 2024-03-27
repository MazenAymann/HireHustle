part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class TriggerOldVisibility extends ChangePasswordState {}

class TriggerNewVisibility extends ChangePasswordState {}

class TriggerConfirmationVisibility extends ChangePasswordState {}

class ConfirmationPasswordFailed extends ChangePasswordState {
  String message;

  ConfirmationPasswordFailed(this.message);
}

class PasswordChanged extends ChangePasswordState {
  String message;

  PasswordChanged(this.message);
}

class ApiRequestError extends ChangePasswordState {
  String message;

  ApiRequestError(this.message);
}