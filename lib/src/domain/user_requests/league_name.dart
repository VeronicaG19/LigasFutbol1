import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum LeagueNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class LeagueName extends FormzInput<String, LeagueNameValidationError> {
  /// {@macro Address}
  const LeagueName.pure() : super.pure('');

  /// {@macro  Address}
  const LeagueName.dirty([String value = '']) : super.dirty(value);

  @override
  LeagueNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : LeagueNameValidationError.invalid;
  }
}