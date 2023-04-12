import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DaysMatchesOrderValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DaysMatchesOrder extends FormzInput<String, DaysMatchesOrderValidationError> {
  /// {@macro Address}
  const DaysMatchesOrder.pure() : super.pure('');

  /// {@macro  Address}
  const DaysMatchesOrder.dirty([String value = '']) : super.dirty(value);

  @override
  DaysMatchesOrderValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DaysMatchesOrderValidationError.invalid;
  }
}