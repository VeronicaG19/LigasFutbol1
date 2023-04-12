import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldImageValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldImage extends FormzInput<String, FieldImageValidationError> {
  /// {@macro Address}
  const FieldImage.pure() : super.pure('');

  /// {@macro  Address}
  const FieldImage.dirty([String value = '']) : super.dirty(value);

  @override
  FieldImageValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FieldImageValidationError.invalid;
  }
}