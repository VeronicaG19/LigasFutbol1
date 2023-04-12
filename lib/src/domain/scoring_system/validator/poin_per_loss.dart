import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum PointPerLossValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class PointPerLoss extends FormzInput<String, PointPerLossValidationError> {
  /// {@macro Address}
  const PointPerLoss.pure() : super.pure('');

  /// {@macro  Address}
  const PointPerLoss.dirty([String value = '']) : super.dirty(value);

  @override
  PointPerLossValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : PointPerLossValidationError.invalid;
  }
}