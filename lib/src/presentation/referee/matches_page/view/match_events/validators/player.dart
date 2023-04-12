import 'package:formz/formz.dart';

enum PlayerValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Player extends FormzInput<String, PlayerValidationError> {
  /// {@macro Address}
  const Player.pure() : super.pure('');

  /// {@macro  Address}
  const Player.dirty([String value = '']) : super.dirty(value);

  @override
  PlayerValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : PlayerValidationError.invalid;
  }
}
