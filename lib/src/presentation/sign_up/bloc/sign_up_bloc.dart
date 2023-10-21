import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/sign_up/models.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository) : super(const SignUpState()) {
    on<SignUpVerificationSenderChanged>(_onVerificationSenderChanged);
    on<SignUpFirstNameChanged>(_onFirstNameChanged);
    on<SignUpLastNameChanged>(_onLastNameChanged);
    on<SignUpUserNameChanged>(_onUserNameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpVerificationPassword>(_onVerificationPasswordChanged);
    on<SignUpVerificationCodeChanged>(_onVerificationCodeChanged);
    on<SignUpVerificationSubmitted>(_submitVerificationSender);
    on<SignUpOnNextStep>(_onNextStep);
    on<SignUpOnBackStep>(_onBackStep);
    on<SignUpOnCancel>(_onCancel);
    on<SignUpResentCode>(_onResentCode);
    on<ChangeTacStatus>(_onChangeTacStatus);
    on<ShowIntroductionMessage>(_onShowIntroductionMessage);
  }

  final AuthenticationRepository _repository;

  void _onVerificationSenderChanged(
    SignUpVerificationSenderChanged event,
    Emitter<SignUpState> emit,
  ) {
    final verificationSender = VerificationSender.dirty(event.value);
    emit(state.copyWith(
      verificationSender: verificationSender,
      status: Formz.validate([verificationSender]),
    ));
  }

  void _onVerificationCodeChanged(
    SignUpVerificationCodeChanged event,
    Emitter<SignUpState> emit,
  ) {
    final verificationCode = VerificationCodeForm.dirty(event.value);
    emit(state.copyWith(
      verificationCode: verificationCode,
      status: Formz.validate([verificationCode]),
    ));
  }

  void _onFirstNameChanged(
    SignUpFirstNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final firstName = FirstName.dirty(event.value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([firstName, state.lastName]),
    ));
  }

  void _onLastNameChanged(
    SignUpLastNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final lastName = LastName.dirty(event.value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([lastName, state.firstName]),
    ));
  }

  void _onUserNameChanged(
    SignUpUserNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final username = Username.dirty(event.value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = Password.dirty(event.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password]),
    ));
  }

  void _onVerificationPasswordChanged(
    SignUpVerificationPassword event,
    Emitter<SignUpState> emit,
  ) {
    Password password = Password.dirty(event.value);
    FormzStatus validation = Formz.validate([password, state.password]);
    if (state.password.value != password.value) {
      validation = FormzStatus.invalid;
      password = const Password.dirty('');
    }
    emit(
      state.copyWith(password2: password, status: validation),
    );
  }

  void _onChangeTacStatus(ChangeTacStatus event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      tacStatus: event.status,
      status: Formz.validate([state.password]),
    ));
  }

  Future<void> _submitVerificationSender(
    SignUpVerificationSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final response = await _repository
        .submitVerificationCode(state.verificationSender.value);
    response.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.code, status: FormzStatus.submissionFailure)),
      (r) => emit(
        state.copyWith(
          status: r.isTheCodeValidated
              ? Formz.validate([state.firstName, state.lastName])
              : Formz.validate([state.verificationCode]),
          signUpStatus: SignUpStatus.userForm,
          username: Username.dirty(state.verificationSender.value),
          verificationType: state.getVerificationType(),
          index: r.isTheCodeValidated ? 1 : 0,
        ),
      ),
    );
  }

  void _onNextStep(SignUpOnNextStep event, Emitter<SignUpState> emit) async {
    if (!state.status.isValidated) {
      return;
    }
    if (state.index == 0) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final validateCode = await _repository
          .submitCodeConfirmation(state.verificationCode.value);
      validateCode.fold(
          (l) => emit(state.copyWith(
              errorMessage: l.code, status: FormzStatus.submissionFailure)),
          (r) => emit(state.copyWith(
              index: 1,
              status: Formz.validate([state.firstName, state.lastName]))));
    } else if (state.index == 1) {
      emit(state.copyWith(
          index: 2, status: Formz.validate([state.username, state.password])));
    } else if (state.index == 2) {
      emit(state.copyWith(status: FormzStatus.pure));
      if (!state.tacStatus) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      } else {
        if (state.password.value != state.password2.value) {
          emit(state.copyWith(
              password2: const Password.dirty(''),
              status: FormzStatus.invalid));
          return;
        }
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        final user = User(
            userName: state.username.value,
            password: state.password.value,
            person: Person.buildPerson(
                firstName: state.firstName.value,
                lastName: state.lastName.value,
                areaCode: 'LF',
                email: state.verificationType == VerificationType.email
                    ? state.verificationSender.value
                    : null,
                phone: state.verificationType == VerificationType.phone
                    ? state.verificationSender.value
                    : null),
            applicationRol: ApplicationRol.player);
        final signUpResponse = await _repository.signUp(user);
        signUpResponse.fold(
            (l) => emit(state.copyWith(
                status: FormzStatus.submissionFailure,
                errorMessage: l.message)),
            (r) => emit(state.copyWith(
                status: FormzStatus.submissionSuccess,
                signUpStatus: SignUpStatus.submitted,
                userModel: r)));
      }
    }
  }

  void _onBackStep(SignUpOnBackStep event, Emitter<SignUpState> emit) {
    if (state.index == 0 || state.index == 1) {
      emit(
        state.copyWith(
          signUpStatus: SignUpStatus.verificationCode,
          status: Formz.validate(
            [state.verificationSender],
          ),
        ),
      );
    } else if (state.index == 2) {
      emit(
        state.copyWith(
          index: 1,
          status: Formz.validate(
            [state.firstName, state.lastName],
          ),
        ),
      );
    }
  }

  void _onCancel(SignUpOnCancel event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
        status: FormzStatus.submissionSuccess, userModel: User.empty));
  }

  Future<void> _onResentCode(
    SignUpResentCode event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final response = await _repository.resentVerificationCode(
        state.verificationSender.value, false);
    response.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.code, status: FormzStatus.submissionFailure)),
      (r) => emit(
        state.copyWith(
          status: Formz.validate([state.verificationCode]),
        ),
      ),
    );
  }

  void _onShowIntroductionMessage(
      ShowIntroductionMessage event, Emitter<SignUpState> emit) {
    emit(state.copyWith(signUpStatus: SignUpStatus.showIntroduction));
    emit(state.copyWith(signUpStatus: SignUpStatus.verificationCode));
  }
}
