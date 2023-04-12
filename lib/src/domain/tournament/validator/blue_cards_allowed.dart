import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum BlueCardsAllowedValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class BlueCardsAllowed extends FormzInput<String, BlueCardsAllowedValidationError> {
  /// {@macro Address}
  const BlueCardsAllowed.pure() : super.pure('');

  /// {@macro  Address}
  const BlueCardsAllowed.dirty([String value = '']) : super.dirty(value);

  @override
  BlueCardsAllowedValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : BlueCardsAllowedValidationError.invalid;
  }
}