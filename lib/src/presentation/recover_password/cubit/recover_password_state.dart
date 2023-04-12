part of 'recover_password_cubit.dart';

class RecoverPasswordState extends Equatable {
  const RecoverPasswordState(
      {this.userSender = const VerificationSender.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage});

  final VerificationSender userSender;
  final FormzStatus status;
  final String? errorMessage;

  RecoverPasswordState copyWith({
    VerificationSender? userSender,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RecoverPasswordState(
      userSender: userSender ?? this.userSender,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userSender, status];
}
