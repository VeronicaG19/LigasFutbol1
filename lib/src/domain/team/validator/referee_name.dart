import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum RefereeNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class RefereeName extends FormzInput<String, RefereeNameValidationError> {
  /// {@macro password}
  /// inicializar el objeto cuando este vacio
  /// siempre
  const RefereeName.pure() : super.pure('');

  /// {@macro password}
  /// pasar un parametro para inicializar la clase
  const RefereeName.dirty([String value = '']) : super.dirty(value);

  @override
  RefereeNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : RefereeNameValidationError.invalid;
  }
}
