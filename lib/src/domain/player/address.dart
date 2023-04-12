import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum AddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Address extends FormzInput<String, AddressValidationError> {
  /// {@macro Address}
  const Address.pure() : super.pure('');

  /// {@macro  Address}
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : AddressValidationError.invalid;
  }
}