import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/sign_up/email_input.dart';
import '../../../../../domain/sign_up/models.dart';
import '../../../../../domain/sign_up/phone_input.dart';

part 'personal_data_state.dart';

@Injectable()
class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit(this._userRepository, this._authenticationRepository)
      : super(const PersonalDataState());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  void onFirstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate(
          [firstName, state.lastName],
        ),
      ),
    );
  }

  void onLastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate(
          [lastName, state.firstName],
        ),
      ),
    );
  }

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(
      state.copyWith(
        emailInput: email,
        status: Formz.validate(
          [email],
        ),
      ),
    );
  }

  void onPhoneChanged(String value) {
    final phone = PhoneInput.dirty(value);
    emit(
      state.copyWith(
        phoneInput: phone,
        status: Formz.validate(
          [phone],
        ),
      ),
    );
  }

  void onVerificationCodeChanged(String value) {
    final verificationCode = VerificationCodeForm.dirty(value);
    emit(state.copyWith(
      verificationCode: verificationCode,
      status: Formz.validate([verificationCode]),
    ));
  }

  void getCacheVerificationCode(PersonalDataSubmitAction action) {
    if (action == PersonalDataSubmitAction.updatePersonName) return;
    final type =
        PersonalDataSubmitAction.updateEmail == action ? 'email' : 'phone';
    final response = _authenticationRepository.getCacheCodeForUpdate(type);
    emit(state.copyWith(
        isVerificationScreen: response.isNotEmpty,
        code: response,
        action: action));
  }

  Future<void> onResentVerificationCode(User user) async {
    final type = PersonalDataSubmitAction.updateEmail == state.action
        ? 'email'
        : 'phone';
    final data = _authenticationRepository.getCacheCodeForUpdate(type);
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final response = await _authenticationRepository.resentVerificationCode(
        data.receiver, true);
    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        code: response.getOrElse(() => VerificationCode.empty)));
  }

  void onCancelUpdateRequest() {
    final type = PersonalDataSubmitAction.updateEmail == state.action
        ? 'email'
        : 'phone';
    _authenticationRepository.clearUpdateRequest(type);
    emit(state.copyWith(isVerificationScreen: false));
  }

  Future<void> onSubmitVerificationCode(User user) async {
    final type = PersonalDataSubmitAction.updateEmail == state.action
        ? 'email'
        : 'phone';
    onVerificationCodeChanged(state.verificationCode.value);
    if (state.status.isInvalid) return;
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress, hasUpdatedUserName: false));
    final codeRequest =
        await _authenticationRepository.submitVerificationCodeForDataUpdate(
            state.verificationCode.value, type);
    if (codeRequest.isRight()) {
      if (type == 'email') {
        final isChangingUser = user.person.getMainEmail == user.userName;
        final request = await _userRepository.changeEmail(
            codeRequest.getOrElse(() => VerificationCode.empty).receiver,
            user,
            isChangingUser);
        request.fold(
          (l) => emit(
            state.copyWith(
              errorMessage: l.code == 'emailExists'
                  ? 'El correo que introdujiste ya está registrado'
                  : 'No se pudo actualizar el correo electrónico',
              status: FormzStatus.submissionFailure,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              user: r,
              hasUpdatedUserName: isChangingUser,
              code: codeRequest.getOrElse(() => VerificationCode.empty),
            ),
          ),
        );
      } else {
        final isChangingUser =
            user.person.getUnformattedMainPhone == user.userName;
        final request = await _userRepository.changePhone(
            codeRequest.getOrElse(() => VerificationCode.empty).receiver,
            user,
            isChangingUser);
        request.fold(
          (l) => emit(
            state.copyWith(
              errorMessage: l.code == 'phoneExists'
                  ? 'El teléfono que introdujiste ya está registrado'
                  : 'No se pudo actualizar el teléfono',
              status: FormzStatus.submissionFailure,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              user: r,
              hasUpdatedUserName: isChangingUser,
              code: codeRequest.getOrElse(() => VerificationCode.empty),
            ),
          ),
        );
      }
    } else {
      final String failure = codeRequest
          .swap()
          .getOrElse(() => const AuthFailure(code: '', message: ''))
          .code;
      emit(
        state.copyWith(
          errorMessage: failure == 'invalidCode'
              ? 'El código es inválido'
              : 'Ha ocurrido un error',
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> onUpdatePersonName(User user) async {
    onFirstNameChanged(state.firstName.value);
    onLastNameChanged(state.lastName.value);
    if (state.status.isInvalid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _userRepository.changePersonName(
        state.firstName.value, state.lastName.value, user);
    request.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzStatus.submissionFailure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          user: r,
          status: FormzStatus.submissionSuccess,
        ),
      ),
    );
  }

  Future<void> onSendVerificationCode(User user) async {
    bool isChangingUser = false;
    String errorMessage = '';
    if (state.action == PersonalDataSubmitAction.updateEmail) {
      onEmailChanged(state.emailInput.value);
      isChangingUser = user.person.getMainEmail == user.userName;
      errorMessage = 'El correo electrónico que escribiste ya está registrado';
    } else if (state.action == PersonalDataSubmitAction.updatePhone) {
      onPhoneChanged(state.phoneInput.value);
      isChangingUser = user.person.getUnformattedMainPhone == user.userName;
      errorMessage = 'El teléfono que escribiste ya está registrado';
    }
    if (state.status.isInvalid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final input = state.action == PersonalDataSubmitAction.updatePhone
        ? state.phoneInput.value
        : state.emailInput.value;
    final response = await _authenticationRepository
        .sendVerificationCodeForDataUpdate(input, isChangingUser);
    response.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.code == 'alreadyExists'
              ? errorMessage
              : 'No se pudo completar el proceso.',
          status: FormzStatus.submissionFailure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isVerificationScreen: true,
          code: r,
          status: FormzStatus.submissionSuccess,
        ),
      ),
    );
  }
}
