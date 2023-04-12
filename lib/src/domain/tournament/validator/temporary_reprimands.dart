import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TemporaryReprimandsValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TemporaryReprimands extends FormzInput<String, TemporaryReprimandsValidationError> {
  /// {@macro Address}
  const TemporaryReprimands.pure() : super.pure('');

  /// {@macro  Address}
  const TemporaryReprimands.dirty([String value = '']) : super.dirty(value);

  @override
  TemporaryReprimandsValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TemporaryReprimandsValidationError.invalid;
  }
}