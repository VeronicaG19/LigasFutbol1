import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../domain/sign_up/models.dart';
import '../../../domain/sign_up/verification_sender.dart';

part 'recover_password_state.dart';

class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  RecoverPasswordCubit(this._authenticationRepository)
      : super(const RecoverPasswordState());

  final AuthenticationRepository _authenticationRepository;

  void onUserSenderChanged(String value) {
    final userSender = VerificationSender.dirty(value);
    emit(state.copyWith(
      userSender: userSender,
      status: Formz.validate([userSender]),
    ));
  }

  Future<void> onChangePassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final response =
        await _authenticationRepository.recoverPassword(state.userSender.value);
    response.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.code, status: FormzStatus.submissionFailure)),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)));
  }
}
