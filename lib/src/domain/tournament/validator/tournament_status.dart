import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TournamentStatusValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TournamentStatus extends FormzInput<String, TournamentStatusValidationError> {
  /// {@macro Address}
  const TournamentStatus.pure() : super.pure('');

  /// {@macro  Address}
  const TournamentStatus.dirty([String value = '']) : super.dirty(value);

  @override
  TournamentStatusValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TournamentStatusValidationError.invalid;
  }
}