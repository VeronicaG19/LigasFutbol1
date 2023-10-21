import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/sign_up/original_password.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../domain/sign_up/password.dart';

part 'account_state.dart';

@Injectable()
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._userRepository) : super(const AccountState());

  final UserRepository _userRepository;
  late final String originalP;

  Future<void> init() async {
    originalP = await _userRepository.getPassword();
  }

  void onOriginalPasswordChanged(String value) {
    OriginalPassword password = OriginalPassword.dirty(value);
    FormzStatus validation =
        Formz.validate([password, state.password, state.password2]);
    if (value != originalP) {
      validation = FormzStatus.invalid;
      password = const OriginalPassword.dirty('');
    }
    emit(
      state.copyWith(
        originalPassword: password,
        status: validation,
      ),
    );
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status:
          Formz.validate([password, state.password2, state.originalPassword]),
    ));
  }

  void onPassword2Changed(String value) {
    Password password = Password.dirty(value);
    FormzStatus validation =
        Formz.validate([password, state.password, state.originalPassword]);
    if (state.password.value != password.value) {
      validation = FormzStatus.invalid;
      password = const Password.dirty('');
    }
    emit(
      state.copyWith(password2: password, status: validation),
    );
  }

  Future<void> onUpdatePassword(User user) async {
    if (!state.status.isValid) return;
    if (state.password2.value != state.password.value) {
      emit(
        state.copyWith(
            password2: const Password.dirty(''), status: FormzStatus.invalid),
      );
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request =
        await _userRepository.changePassword(state.password.value, user);
    request.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzStatus.submissionFailure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      ),
    );
  }
}
