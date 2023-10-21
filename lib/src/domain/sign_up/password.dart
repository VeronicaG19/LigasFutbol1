import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum PasswordValidationError {
  invalid,
  invalidLength,
  noLowerCase,
  noUpperCase,
  noDigit,
  noSymbol,
  consecutiveNumber
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegDigits = RegExp(r'(?=.*\d)');
  static final _passwordRegLower = RegExp(r'(?=.*[a-z])');
  static final _passwordRegUpper = RegExp(r'(?=.*[A-Z])');
  static final _passwordRegSymbol = RegExp(r'(?=.*[\W])');
  //static final _passwordRegConsecutive = RegExp(r'\d{3,}');
  static final _passwordRegConsecutive = RegExp(
    r"((.)(?:(?:0(?=1|\b)|1(?=2|\b)|2(?=3|\b)|3(?=4|\b)|4(?=5|\b)|5(?=6|\b)|6(?=7|\b)|7(?=8|\b)|8(?=9|\b)|9(?=0|\b)){3,}))",
  );

  @override
  PasswordValidationError? validator(String? value) {
    if ((value?.trim().length ?? 0) < 8) {
      return PasswordValidationError.invalidLength;
    }
    if (_passwordRegConsecutive.hasMatch(value ?? '')) {
      return PasswordValidationError.consecutiveNumber;
    }
    if (!_passwordRegLower.hasMatch(value ?? '')) {
      return PasswordValidationError.noLowerCase;
    }
    if (!_passwordRegUpper.hasMatch(value ?? '')) {
      return PasswordValidationError.noUpperCase;
    }
    if (!_passwordRegDigits.hasMatch(value ?? '')) {
      return PasswordValidationError.noDigit;
    }
    if (!_passwordRegSymbol.hasMatch(value ?? '')) {
      return PasswordValidationError.noSymbol;
    }
    return null;
  }
}
