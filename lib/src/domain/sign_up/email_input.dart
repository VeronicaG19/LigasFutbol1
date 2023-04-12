import 'package:formz/formz.dart';

/// Validation errors for the [EmailInput] [FormzInput].
enum EmailInputValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Email Input}
/// Form input for Email Input.
/// {@endtemplate}
class EmailInput extends FormzInput<String, EmailInputValidationError> {
  /// {@macro Email Input}
  const EmailInput.pure() : super.pure('');

  /// {@macro Email Input}
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]');

  @override
  EmailInputValidationError? validator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (_emailRegex.hasMatch(value)) {
        return null;
      } else {
        return EmailInputValidationError.invalid;
      }
    } else {
      return EmailInputValidationError.invalid;
    }
  }
}
