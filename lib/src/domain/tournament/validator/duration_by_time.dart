import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DurationByTimeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DurationByTime extends FormzInput<String, DurationByTimeValidationError> {
  /// {@macro Address}
  const DurationByTime.pure() : super.pure('');

  /// {@macro  Address}
  const DurationByTime.dirty([String value = '']) : super.dirty(value);

  @override
  DurationByTimeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DurationByTimeValidationError.invalid;
  }
}