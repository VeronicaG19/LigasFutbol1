import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

/// Validation errors for the [BirthDate] [FormzInput].
enum BirthDateValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template BirthDate}
/// Form input for a BirthDate input.
/// {@endtemplate}
class BirthDate extends FormzInput<String, BirthDateValidationError> {
  /// {@macro BirthDate}
  const BirthDate.pure() : super.pure('');

  /// {@macro BirthDate}
  const BirthDate.dirty([String value = '']) : super.dirty(value);

  @override
  BirthDateValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BirthDateValidationError.invalid;
  }
}