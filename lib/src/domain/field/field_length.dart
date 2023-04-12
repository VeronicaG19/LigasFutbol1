import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldLengthValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldLength extends FormzInput<String, FieldLengthValidationError> {
  /// {@macro Address}
  const FieldLength.pure() : super.pure('');

  /// {@macro  Address}
  const FieldLength.dirty([String value = '']) : super.dirty(value);

  @override
  FieldLengthValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FieldLengthValidationError.invalid;
  }
}