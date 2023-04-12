import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldTypeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldType extends FormzInput<String, FieldTypeValidationError> {
  /// {@macro Address}
  const FieldType.pure() : super.pure('');

  /// {@macro  Address}
  const FieldType.dirty([String value = '']) : super.dirty(value);

  @override
  FieldTypeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FieldTypeValidationError.invalid;
  }
}