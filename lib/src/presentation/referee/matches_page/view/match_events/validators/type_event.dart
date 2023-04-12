import 'package:formz/formz.dart';

enum TypeEventValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TypeEvent extends FormzInput<String, TypeEventValidationError> {
  /// {@macro Address}
  const TypeEvent.pure() : super.pure('');

  /// {@macro  Address}
  const TypeEvent.dirty([String value = '']) : super.dirty(value);

  @override
  TypeEventValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : TypeEventValidationError.invalid;
  }
}
