import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldlatitudeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldLatitude extends FormzInput<String, FieldlatitudeValidationError> {
  /// {@macro Address}
  const FieldLatitude.pure() : super.pure('');

  /// {@macro  Address}
  const FieldLatitude.dirty([String value = '']) : super.dirty(value);

  @override
  FieldlatitudeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FieldlatitudeValidationError.invalid;
  }
}