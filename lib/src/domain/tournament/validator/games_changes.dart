import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum GamesChangesValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class GamesChanges extends FormzInput<String, GamesChangesValidationError> {
  /// {@macro Address}
  const GamesChanges.pure() : super.pure('');

  /// {@macro  Address}
  const GamesChanges.dirty([String value = '']) : super.dirty(value);

  @override
  GamesChangesValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : GamesChangesValidationError.invalid;
  }
}