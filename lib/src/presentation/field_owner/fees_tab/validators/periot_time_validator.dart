import 'package:formz/formz.dart';

enum PeriotTimeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PeriotTime extends FormzInput<String, PeriotTimeValidationError> {
  /// {@macro Address}
  const PeriotTime.pure() : super.pure('');

  /// {@macro  Address}
  const PeriotTime.dirty([String value = '']) : super.dirty(value);

  @override
  PeriotTimeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : PeriotTimeValidationError.invalid;
  }
}
