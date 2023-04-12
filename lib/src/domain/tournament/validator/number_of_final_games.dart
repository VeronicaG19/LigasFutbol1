import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum NumberOfFinalGamesValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class NumberOfFinalGames extends FormzInput<String, NumberOfFinalGamesValidationError> {
  /// {@macro Address}
  const NumberOfFinalGames.pure() : super.pure('');

  /// {@macro  Address}
  const NumberOfFinalGames.dirty([String value = '']) : super.dirty(value);

  @override
  NumberOfFinalGamesValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : NumberOfFinalGamesValidationError.invalid;
  }
}