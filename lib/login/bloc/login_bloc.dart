import 'package:bloc/bloc.dart';
import 'package:devel_app/login/service/firebase_auth_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<FirebaseAuthLoggedIn>(_onLoggedIn);
    on<FirebaseAuthSignedUp>(_onSignedUp);
  }

  final FirebaseAuthServices _authRepository = FirebaseAuthServices();

  Future<void> _onLoggedIn(
    FirebaseAuthLoggedIn event,
    Emitter<LoginState> emit,
  ) async {
    emit(AuthentincationInProgress());
    try {
      final UserCredential response = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(UserAuthenticated(user: response.user!));
    } on FirebaseAuthException catch (exception) {
      emit(
        UserUnauthenticated(
          message: exception.message ?? 'Credenciales inválidas',
        ),
      );
    } catch (_) {
      emit(AuthenticationError(message: 'Ocurrió un error inesperado'));
    }
  }

  Future<void> _onSignedUp(
    FirebaseAuthSignedUp event,
    Emitter<LoginState> emit,
  ) async {
    emit(AuthentincationInProgress());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );
    } on FirebaseAuthException catch (exception) {
      emit(
        UserUnauthenticated(
          message: exception.message ?? 'Error al registrar usuario',
        ),
      );
    } catch (_) {
      emit(AuthenticationError(message: 'Ocurrió un error inesperado'));
    }
  }
}
