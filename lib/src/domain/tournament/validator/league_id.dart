import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum LeagueIdValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class LeagueId extends FormzInput<String, LeagueIdValidationError> {
  /// {@macro Address}
  const LeagueId.pure() : super.pure('');

  /// {@macro  Address}
  const LeagueId.dirty([String value = '']) : super.dirty(value);

  @override
  LeagueIdValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : LeagueIdValidationError.invalid;
  }
}