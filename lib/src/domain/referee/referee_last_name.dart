import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RefereeLastNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RefereeLastName extends FormzInput<String, RefereeLastNameValidationError> {
  /// {@macro Address}
  const RefereeLastName.pure() : super.pure('');

  /// {@macro  Address}
  const RefereeLastName.dirty([String value = '']) : super.dirty(value);

  @override
  RefereeLastNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : RefereeLastNameValidationError.invalid;
  }
}