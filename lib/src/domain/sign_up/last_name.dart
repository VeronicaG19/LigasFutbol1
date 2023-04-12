import 'package:formz/formz.dart';

/// Validation errors for the [LastName] [FormzInput].
enum LastNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template last name}
/// Form input for a last name input.
/// {@endtemplate}
class LastName extends FormzInput<String, LastNameValidationError> {
  /// {@macro last name}
  const LastName.pure() : super.pure('');

  /// {@macro last name}
  const LastName.dirty([String value = '']) : super.dirty(value);

  @override
  LastNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : LastNameValidationError.invalid;
  }
}
