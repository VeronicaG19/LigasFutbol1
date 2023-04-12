import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum TieBreakTypeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TieBreakType extends FormzInput<String, TieBreakTypeValidationError> {
  /// {@macro Address}
  const TieBreakType.pure() : super.pure('');

  /// {@macro  Address}
  const TieBreakType.dirty([String value = '']) : super.dirty(value);

  @override
  TieBreakTypeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : TieBreakTypeValidationError.invalid;
  }
}