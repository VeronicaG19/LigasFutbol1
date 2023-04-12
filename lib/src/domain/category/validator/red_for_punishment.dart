import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum RedForPunishmentValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class RedForPunishment
    extends FormzInput<String, RedForPunishmentValidationError> {
  /// {@macro password}
  const RedForPunishment.pure() : super.pure('');

  /// {@macro password}
  const RedForPunishment.dirty([String value = '']) : super.dirty(value);

  @override
  RedForPunishmentValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true && int.parse(value!.trim()) > 0
        ? null
        : RedForPunishmentValidationError.invalid;
  }
}
