import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum SancionTimeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class SancionTime extends FormzInput<String, SancionTimeValidationError> {
  /// {@macro Address}
  const SancionTime.pure() : super.pure('');

  /// {@macro  Address}
  const SancionTime.dirty([String value = '']) : super.dirty(value);

  @override
  SancionTimeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : SancionTimeValidationError.invalid;
  }
}