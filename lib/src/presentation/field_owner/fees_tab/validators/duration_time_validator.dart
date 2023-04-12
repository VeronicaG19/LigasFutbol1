import 'package:formz/formz.dart';

enum DurationTimeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DurationTime extends FormzInput<String, DurationTimeValidationError> {
  /// {@macro Address}
  const DurationTime.pure() : super.pure('');

  /// {@macro  Address}
  const DurationTime.dirty([String value = '']) : super.dirty(value);

  @override
  DurationTimeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : DurationTimeValidationError.invalid;
  }
}
