import 'package:formz/formz.dart';

/// Validation errors for the [PhoneInput] [FormzInput].
enum PhoneInputValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Phone Input}
/// Form input for Phone Input.
/// {@endtemplate}
class PhoneInput extends FormzInput<String, PhoneInputValidationError> {
  /// {@macro Email Input}
  const PhoneInput.pure() : super.pure('');

  /// {@macro Email Input}
  const PhoneInput.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegExp = RegExp(r'^[0-9]{10}');

  @override
  PhoneInputValidationError? validator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (_phoneRegExp.hasMatch(value)) {
        return null;
      } else {
        return PhoneInputValidationError.invalid;
      }
    } else {
      return PhoneInputValidationError.invalid;
    }
  }
}
