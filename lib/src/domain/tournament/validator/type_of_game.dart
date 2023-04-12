import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TypeOfGameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TypeOfGame extends FormzInput<String, TypeOfGameValidationError> {
  /// {@macro Address}
  const TypeOfGame.pure() : super.pure('');

  /// {@macro  Address}
  const TypeOfGame.dirty([String value = '']) : super.dirty(value);

  @override
  TypeOfGameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TypeOfGameValidationError.invalid;
  }
}