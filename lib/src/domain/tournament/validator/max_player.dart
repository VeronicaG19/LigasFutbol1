import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum MaxPlayerValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class MaxPlayer extends FormzInput<String, MaxPlayerValidationError> {
  /// {@macro Address}
  const MaxPlayer.pure() : super.pure('');

  /// {@macro  Address}
  const MaxPlayer.dirty([String value = '']) : super.dirty(value);

  @override
  MaxPlayerValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : MaxPlayerValidationError.invalid;
  }
}