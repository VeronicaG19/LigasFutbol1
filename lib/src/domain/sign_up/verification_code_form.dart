import 'package:formz/formz.dart';

/// Validation errors for the [VerificationCode] [FormzInput].
enum VerificationCodeError {
  /// Generic invalid error.
  invalid
}

/// {@template verificationCode}
/// Form input for a verificationCode input.
/// {@endtemplate}
class VerificationCodeForm extends FormzInput<String, VerificationCodeError> {
  /// {@macro verificationCode}
  const VerificationCodeForm.pure() : super.pure('');

  /// {@macro verificationCode}
  const VerificationCodeForm.dirty([String value = '']) : super.dirty(value);

  @override
  VerificationCodeError? validator(String? value) {
    return value?.isNotEmpty == true && value!.trim().length == 4
        ? null
        : VerificationCodeError.invalid;
  }
}
