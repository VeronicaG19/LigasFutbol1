import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum MaxTeamsValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class MaxTeams extends FormzInput<String, MaxTeamsValidationError> {
  /// {@macro Address}
  const MaxTeams.pure() : super.pure('');

  /// {@macro  Address}
  const MaxTeams.dirty([String value = '']) : super.dirty(value);

  @override
  MaxTeamsValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : MaxTeamsValidationError.invalid;
  }
}