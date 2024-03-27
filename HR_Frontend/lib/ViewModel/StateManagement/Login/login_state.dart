part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class TriggerVisibility extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final loginFailedMessage;

  LoginFailed(this.loginFailedMessage);
}

class ApiRequestFailed extends LoginState {
  final apiRequestErrorMessage;

  ApiRequestFailed(this.apiRequestErrorMessage);
}