import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum MinAgeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class MinAge extends FormzInput<String, MinAgeValidationError> {
  /// {@macro password}
  const MinAge.pure() : super.pure('');

  /// {@macro password}
  const MinAge.dirty([String value = '']) : super.dirty(value);

  @override
  MinAgeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true && int.parse(value!.trim()) > 0
        ? null
        : MinAgeValidationError.invalid;
  }
}
