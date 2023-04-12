import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TypeTournamentValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TypeTournament extends FormzInput<String, TypeTournamentValidationError> {
  /// {@macro Address}
  const TypeTournament.pure() : super.pure('');

  /// {@macro  Address}
  const TypeTournament.dirty([String value = '']) : super.dirty(value);

  @override
  TypeTournamentValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TypeTournamentValidationError.invalid;
  }
}