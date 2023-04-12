import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RoundsValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Rounds extends FormzInput<String, RoundsValidationError> {
  /// {@macro Address}
  const Rounds.pure() : super.pure('');

  /// {@macro  Address}
  const Rounds.dirty([String value = '']) : super.dirty(value);

  @override
  RoundsValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : RoundsValidationError.invalid;
  }
}