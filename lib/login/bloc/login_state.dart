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

final class AuthenticationError extends LoginState {
  final String message;
  const AuthenticationError({required this.message});
}
