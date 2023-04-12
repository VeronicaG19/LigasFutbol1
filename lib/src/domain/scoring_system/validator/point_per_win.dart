import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum PointPerWinValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PointPerWin extends FormzInput<String, PointPerWinValidationError> {
  /// {@macro Address}
  const PointPerWin.pure() : super.pure('');

  /// {@macro  Address}
  const PointPerWin.dirty([String value = '']) : super.dirty(value);

  @override
  PointPerWinValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : PointPerWinValidationError.invalid;
  }
}