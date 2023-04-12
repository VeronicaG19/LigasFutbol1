import 'package:formz/formz.dart';

/// Validation errors for the [PositionPlayer] [FormzInput].
enum PositionPlayerValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template nick name}
/// Form input for a PositionPlayer input.
/// {@endtemplate}
class PositionPlayer extends FormzInput<String, PositionPlayerValidationError> {
  /// {@macro PositionPlayer}
  const PositionPlayer.pure() : super.pure('');

  /// {@macro PositionPlayer}
  const PositionPlayer.dirty([String value = '']) : super.dirty(value);

  @override
  PositionPlayerValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PositionPlayerValidationError.invalid;
  }
}