part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

final class LoginInitial extends LoginState {}

final class AuthentincationInProgress extends LoginState {}

final class UserAuthenticated extends LoginState {
  final User user;
  const UserAuthenticated({required this.user});
}

final class UserUnauthenticated extends LoginState {
  final String message;
  const UserUnauthenticated({required this.message});
}

final class LoginException extends LoginState {
  final String message;
  const LoginException({required this.message});
}

final class SurveyObtainedSuccess extends LoginState {
  final SurveyModel survey;
  const SurveyObtainedSuccess({required this.survey});
}
