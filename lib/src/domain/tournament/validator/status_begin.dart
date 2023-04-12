import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum StatusBeginValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class StatusBegin extends FormzInput<String, StatusBeginValidationError> {
  /// {@macro Address}
  const StatusBegin.pure() : super.pure('');

  /// {@macro  Address}
  const StatusBegin.dirty([String value = '']) : super.dirty(value);

  @override
  StatusBeginValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : StatusBeginValidationError.invalid;
  }
}