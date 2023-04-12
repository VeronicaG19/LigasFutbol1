part of 'personal_data_cubit.dart';

class PersonalDataState extends Equatable {
  final FirstName firstName;
  final LastName lastName;
  final EmailInput emailInput;
  final PhoneInput phoneInput;
  final VerificationCodeForm verificationCode;
  final VerificationCode code;
  final bool isVerificationScreen;
  final bool hasUpdatedUserName;
  final User user;
  final PersonalDataSubmitAction action;
  final FormzStatus status;
  final String? errorMessage;

  const PersonalDataState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.emailInput = const EmailInput.pure(),
    this.phoneInput = const PhoneInput.pure(),
    this.verificationCode = const VerificationCodeForm.pure(),
    this.code = VerificationCode.empty,
    this.isVerificationScreen = false,
    this.hasUpdatedUserName = false,
    this.user = User.empty,
    this.action = PersonalDataSubmitAction.updatePersonName,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  PersonalDataState copyWith({
    FirstName? firstName,
    LastName? lastName,
    EmailInput? emailInput,
    PhoneInput? phoneInput,
    VerificationCodeForm? verificationCode,
    VerificationCode? code,
    bool? isVerificationScreen,
    bool? hasUpdatedUserName,
    User? user,
    PersonalDataSubmitAction? action,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return PersonalDataState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailInput: emailInput ?? this.emailInput,
      phoneInput: phoneInput ?? this.phoneInput,
      verificationCode: verificationCode ?? this.verificationCode,
      isVerificationScreen: isVerificationScreen ?? this.isVerificationScreen,
      code: code ?? this.code,
      user: user ?? this.user,
      hasUpdatedUserName: hasUpdatedUserName ?? this.hasUpdatedUserName,
      action: action ?? this.action,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        emailInput,
        phoneInput,
        verificationCode,
        isVerificationScreen,
        hasUpdatedUserName,
        action,
        code,
        user,
        status,
      ];
}
