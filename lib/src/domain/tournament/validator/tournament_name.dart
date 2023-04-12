import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TournamentNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TournamentName extends FormzInput<String, TournamentNameValidationError> {
  /// {@macro Address}
  const TournamentName.pure() : super.pure('');

  /// {@macro  Address}
  const TournamentName.dirty([String value = '']) : super.dirty(value);

  @override
  TournamentNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TournamentNameValidationError.invalid;
  }
}