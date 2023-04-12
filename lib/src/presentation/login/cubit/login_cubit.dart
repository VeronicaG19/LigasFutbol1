import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/login/models.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  //final String languageCode;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    ));
  }

  void onChangePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _authenticationRepository.loginWithNameAndPassword(
        name: state.username.value, password: state.password.value);
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, status: FormzStatus.submissionFailure)),
        (r) => emit(
            state.copyWith(status: FormzStatus.submissionSuccess, token: r)));
  }

  Future<void> loginAfterSignUp(String user, String password) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _authenticationRepository.loginWithNameAndPassword(
        name: user, password: password);
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, status: FormzStatus.submissionFailure)),
        (r) => emit(
            state.copyWith(status: FormzStatus.submissionSuccess, token: r)));
  }
}
