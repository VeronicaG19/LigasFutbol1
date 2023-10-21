import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum PasswordValidationError {
  invalid,
  invalidLength,
  noLowerCase,
  noUpperCase,
  noDigit,
  noSymbol,
  consecutiveNumber
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class OriginalPassword extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const OriginalPassword.pure() : super.pure('');

  /// {@macro password}
  const OriginalPassword.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if ((value?.trim().length ?? 0) < 8) {
      return PasswordValidationError.invalidLength;
    }
    return null;
  }
}
