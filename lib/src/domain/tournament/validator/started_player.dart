import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum StartedPlayerValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class StartedPlayer extends FormzInput<String, StartedPlayerValidationError> {
  /// {@macro Address}
  const StartedPlayer.pure() : super.pure('');

  /// {@macro  Address}
  const StartedPlayer.dirty([String value = '']) : super.dirty(value);

  @override
  StartedPlayerValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : StartedPlayerValidationError.invalid;
  }
}