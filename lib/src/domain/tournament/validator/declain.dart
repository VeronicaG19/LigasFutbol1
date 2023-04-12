import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DeclainValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Declain extends FormzInput<String, DeclainValidationError> {
  /// {@macro Address}
  const Declain.pure() : super.pure('');

  /// {@macro  Address}
  const Declain.dirty([String value = '']) : super.dirty(value);

  @override
  DeclainValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DeclainValidationError.invalid;
  }
}