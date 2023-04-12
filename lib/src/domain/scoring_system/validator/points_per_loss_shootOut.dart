import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum PointsPerLossShootOutValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PointsPerLossShootOut extends FormzInput<String, PointsPerLossShootOutValidationError> {
  /// {@macro Address}
  const PointsPerLossShootOut.pure() : super.pure('');

  /// {@macro  Address}
  const PointsPerLossShootOut.dirty([String value = '']) : super.dirty(value);

  @override
  PointsPerLossShootOutValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : PointsPerLossShootOutValidationError.invalid;
  }
}