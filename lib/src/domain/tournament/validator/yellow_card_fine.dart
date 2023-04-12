import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum YellowCardFineValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class YellowCardFine extends FormzInput<String, YellowCardFineValidationError> {
  /// {@macro Address}
  const YellowCardFine.pure() : super.pure('');

  /// {@macro  Address}
  const YellowCardFine.dirty([String value = '']) : super.dirty(value);

  @override
  YellowCardFineValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : YellowCardFineValidationError.invalid;
  }
}