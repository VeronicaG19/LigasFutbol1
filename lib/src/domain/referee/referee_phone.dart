import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RefereePhoneValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RefereePhone extends FormzInput<String, RefereePhoneValidationError> {
  /// {@macro Address}
  const RefereePhone.pure() : super.pure('');

  /// {@macro  Address}
  const RefereePhone.dirty([String value = '']) : super.dirty(value);

  @override
  RefereePhoneValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RefereePhoneValidationError.invalid;
  }
}