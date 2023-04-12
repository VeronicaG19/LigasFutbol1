import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DaysMatchesValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DaysMatches extends FormzInput<String, DaysMatchesValidationError> {
  /// {@macro Address}
  const DaysMatches.pure() : super.pure('');

  /// {@macro  Address}
  const DaysMatches.dirty([String value = '']) : super.dirty(value);

  @override
  DaysMatchesValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DaysMatchesValidationError.invalid;
  }
}