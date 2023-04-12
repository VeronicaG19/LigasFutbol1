import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TypeExpulsionValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TypeExpulsion extends FormzInput<String, TypeExpulsionValidationError> {
  /// {@macro Address}
  const TypeExpulsion.pure() : super.pure('');

  /// {@macro  Address}
  const TypeExpulsion.dirty([String value = '']) : super.dirty(value);

  @override
  TypeExpulsionValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TypeExpulsionValidationError.invalid;
  }
}