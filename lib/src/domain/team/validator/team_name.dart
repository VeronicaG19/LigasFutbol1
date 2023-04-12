import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum TeamNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class TeamName extends FormzInput<String, TeamNameValidationError> {
  /// {@macro password}
  /// inicializar el objeto cuando este vacio
  /// siempre
  const TeamName.pure() : super.pure('');

  /// {@macro password}
  /// pasar un parametro para inicializar la clase
  const TeamName.dirty([String value = '']) : super.dirty(value);

  @override
  TeamNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : TeamNameValidationError.invalid;
  }
}
