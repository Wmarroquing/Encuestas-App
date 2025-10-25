part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => <Object>[];
}

class FirebaseAuthLoggedIn extends LoginEvent {
  final String email;
  final String password;

  const FirebaseAuthLoggedIn({required this.email, required this.password});
}

class FirebaseAuthSignedUp extends LoginEvent {
  final String email;
  final String password;

  const FirebaseAuthSignedUp({required this.email, required this.password});
}

class FirebaseAuthLoggedOut extends LoginEvent {}
