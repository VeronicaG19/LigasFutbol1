part of 'account_cubit.dart';

class AccountState extends Equatable {
  final Password password;
  final Password password2;
  final OriginalPassword originalPassword;
  final FormzStatus status;
  final String? errorMessage;

  const AccountState({
    this.password = const Password.pure(),
    this.password2 = const Password.pure(),
    this.originalPassword = const OriginalPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  AccountState copyWith({
    Password? password,
    Password? password2,
    OriginalPassword? originalPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return AccountState(
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      originalPassword: originalPassword ?? this.originalPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        password,
        password2,
        originalPassword,
        status,
      ];
}
