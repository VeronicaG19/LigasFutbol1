import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldName extends FormzInput<String, FieldNameValidationError> {
  /// {@macro Address}
  const FieldName.pure() : super.pure('');

  /// {@macro  Address}
  const FieldName.dirty([String value = '']) : super.dirty(value);

  @override
  FieldNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : FieldNameValidationError.invalid;
  }
}