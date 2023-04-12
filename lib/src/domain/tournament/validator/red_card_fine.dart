import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RedCardFineValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RedCardFine extends FormzInput<String, RedCardFineValidationError> {
  /// {@macro Address}
  const RedCardFine.pure() : super.pure('');

  /// {@macro  Address}
  const RedCardFine.dirty([String value = '']) : super.dirty(value);

  @override
  RedCardFineValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : RedCardFineValidationError.invalid;
  }
}