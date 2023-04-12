import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum BreakNumbersValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class BreakNumbers extends FormzInput<String, BreakNumbersValidationError> {
  /// {@macro Address}
  const BreakNumbers.pure() : super.pure('');

  /// {@macro  Address}
  const BreakNumbers.dirty([String value = '']) : super.dirty(value);

  @override
  BreakNumbersValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : BreakNumbersValidationError.invalid;
  }
}