import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum LeagueDescriptionValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class LeagueDescription extends FormzInput<String, LeagueDescriptionValidationError> {
  /// {@macro Address}
  const LeagueDescription.pure() : super.pure('');

  /// {@macro  Address}
  const LeagueDescription.dirty([String value = '']) : super.dirty(value);

  @override
  LeagueDescriptionValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : LeagueDescriptionValidationError.invalid;
  }
}