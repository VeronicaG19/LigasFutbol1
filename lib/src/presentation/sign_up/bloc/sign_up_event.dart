part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpVerificationSenderChanged extends SignUpEvent {
  const SignUpVerificationSenderChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpVerificationCodeChanged extends SignUpEvent {
  const SignUpVerificationCodeChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpFirstNameChanged extends SignUpEvent {
  const SignUpFirstNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpLastNameChanged extends SignUpEvent {
  const SignUpLastNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpUserNameChanged extends SignUpEvent {
  const SignUpUserNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpVerificationPassword extends SignUpEvent {
  const SignUpVerificationPassword(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SignUpVerificationSubmitted extends SignUpEvent {
  const SignUpVerificationSubmitted();

  @override
  List<Object?> get props => [];
}

class SignUpResentCode extends SignUpEvent {
  const SignUpResentCode();

  @override
  List<Object?> get props => [];
}

class SignUpOnNextStep extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class SignUpOnBackStep extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class SignUpOnCancel extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class ChangeTacStatus extends SignUpEvent {
  const ChangeTacStatus(this.status);
  final bool status;
  @override
  List<Object?> get props => [status];
}

class ShowIntroductionMessage extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
