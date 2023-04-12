import 'package:formz/formz.dart';

/// Validation errors for the [FirstName] [FormzInput].
enum FirstNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template first name}
/// Form input for a first name input.
/// {@endtemplate}
class FirstName extends FormzInput<String, FirstNameValidationError> {
  /// {@macro first name}
  const FirstName.pure() : super.pure('');

  /// {@macro first name}
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  FirstNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FirstNameValidationError.invalid;
  }
}
