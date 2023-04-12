import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum PointPerTieValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PointPerTie extends FormzInput<String, PointPerTieValidationError> {
  /// {@macro Address}
  const PointPerTie.pure() : super.pure('');

  /// {@macro  Address}
  const PointPerTie.dirty([String value = '']) : super.dirty(value);

  @override
  PointPerTieValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : PointPerTieValidationError.invalid;
  }
}