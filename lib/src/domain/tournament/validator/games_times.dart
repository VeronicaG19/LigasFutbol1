import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum GamesTimesValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class GamesTimes extends FormzInput<String, GamesTimesValidationError> {
  /// {@macro Address}
  const GamesTimes.pure() : super.pure('');

  /// {@macro  Address}
  const GamesTimes.dirty([String value = '']) : super.dirty(value);

  @override
  GamesTimesValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : GamesTimesValidationError.invalid;
  }
}