import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum FieldAddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class FieldAddres extends FormzInput<String, FieldAddressValidationError> {
  /// {@macro Address}
  const FieldAddres.pure() : super.pure('');

  /// {@macro  Address}
  const FieldAddres.dirty([String value = '']) : super.dirty(value);

  @override
  FieldAddressValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true  ? null : FieldAddressValidationError.invalid;
  }
}