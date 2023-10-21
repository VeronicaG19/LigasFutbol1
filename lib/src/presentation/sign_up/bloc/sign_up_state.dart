part of 'sign_up_bloc.dart';

enum SignUpStatus { verificationCode, userForm, submitted, showIntroduction }

enum VerificationType { unknown, email, phone }

class SignUpState extends Equatable {
  const SignUpState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.password = const Password.pure(),
    this.password2 = const Password.pure(),
    this.username = const Username.pure(),
    this.verificationCode = const VerificationCodeForm.pure(),
    this.verificationSender = const VerificationSender.pure(),
    this.signUpStatus = SignUpStatus.verificationCode,
    this.verificationType = VerificationType.unknown,
    this.index = 0,
    this.tacStatus = false,
    this.userModel = User.empty,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final FirstName firstName;
  final LastName lastName;
  final Password password;
  final Password password2;
  final Username username;
  final VerificationCodeForm verificationCode;
  final VerificationSender verificationSender;
  final SignUpStatus signUpStatus;
  final VerificationType verificationType;
  final int index;
  final bool tacStatus;
  final User userModel;
  final FormzStatus status;
  final String? errorMessage;

  SignUpState copyWith({
    FirstName? firstName,
    LastName? lastName,
    Password? password,
    Password? password2,
    Username? username,
    VerificationCodeForm? verificationCode,
    VerificationSender? verificationSender,
    SignUpStatus? signUpStatus,
    VerificationType? verificationType,
    int? index,
    bool? tacStatus,
    User? userModel,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      verificationCode: verificationCode ?? this.verificationCode,
      verificationSender: verificationSender ?? this.verificationSender,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      verificationType: verificationType ?? this.verificationType,
      index: index ?? this.index,
      tacStatus: tacStatus ?? this.tacStatus,
      userModel: userModel ?? this.userModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        password,
        password2,
        username,
        verificationCode,
        verificationSender,
        signUpStatus,
        verificationType,
        index,
        tacStatus,
        userModel,
        status,
      ];

  String? getErrorCode() {
    try {
      final response = jsonDecode(errorMessage ?? '');
      return response['code'].toString();
    } catch (_) {
      return errorMessage;
    }
  }

  String getResetTime() {
    try {
      final response = jsonDecode(errorMessage ?? '');
      return response['time'].toString();
    } catch (_) {
      return errorMessage ?? '';
    }
  }

  VerificationType getVerificationType() {
    final phoneRegExp = RegExp(r'^[0-9]{10}');
    if (phoneRegExp.hasMatch(verificationSender.value) &&
        verificationSender.value.length == 10) {
      return VerificationType.phone;
    }
    return VerificationType.email;
  }

  // bool validatePassword() {
  //   if (password != repeatPass) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
