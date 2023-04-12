import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum MaxAgeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class MaxAge extends FormzInput<String, MaxAgeValidationError> {
  /// {@macro password}
  const MaxAge.pure() : super.pure('');

  /// {@macro password}
  const MaxAge.dirty([String value = '']) : super.dirty(value);

  @override
  MaxAgeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true && int.parse(value!.trim()) > 0
        ? null
        : MaxAgeValidationError.invalid;
  }
}
