import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum YellowForPunishmentValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class YellowForPunishment
    extends FormzInput<String, YellowForPunishmentValidationError> {
  /// {@macro password}
  const YellowForPunishment.pure() : super.pure('');

  /// {@macro password}
  const YellowForPunishment.dirty([String value = '']) : super.dirty(value);

  @override
  YellowForPunishmentValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true && int.parse(value!.trim()) > 0
        ? null
        : YellowForPunishmentValidationError.invalid;
  }
}
