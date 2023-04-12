import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum InscriptionDateValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class InscriptionDate extends FormzInput<String, InscriptionDateValidationError> {
  /// {@macro Address}
  const InscriptionDate.pure() : super.pure('');

  /// {@macro  Address}
  const InscriptionDate.dirty([String value = '']) : super.dirty(value);

  @override
  InscriptionDateValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : InscriptionDateValidationError.invalid;
  }
}