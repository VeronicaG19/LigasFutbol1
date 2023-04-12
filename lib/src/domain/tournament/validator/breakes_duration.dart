import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum BreakDurationValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class BreakDuration extends FormzInput<String, BreakDurationValidationError> {
  /// {@macro Address}
  const BreakDuration.pure() : super.pure('');

  /// {@macro  Address}
  const BreakDuration.dirty([String value = '']) : super.dirty(value);

  @override
  BreakDurationValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : BreakDurationValidationError.invalid;
  }
}