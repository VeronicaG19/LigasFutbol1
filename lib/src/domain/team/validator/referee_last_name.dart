import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum RefereeLastNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class RefereeLastName
    extends FormzInput<String, RefereeLastNameValidationError> {
  /// {@macro password}
  /// inicializar el objeto cuando este vacio
  /// siempre
  const RefereeLastName.pure() : super.pure('');

  /// {@macro password}
  /// pasar un parametro para inicializar la clase
  const RefereeLastName.dirty([String value = '']) : super.dirty(value);

  @override
  RefereeLastNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : RefereeLastNameValidationError.invalid;
  }
}
