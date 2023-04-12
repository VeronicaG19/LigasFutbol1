import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum PointsPerWinShootOutValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PointsPerWinShootOut extends FormzInput<String, PointsPerWinShootOutValidationError> {
  /// {@macro Address}
  const PointsPerWinShootOut.pure() : super.pure('');

  /// {@macro  Address}
  const PointsPerWinShootOut.dirty([String value = '']) : super.dirty(value);

  @override
  PointsPerWinShootOutValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : PointsPerWinShootOutValidationError.invalid;
  }
}