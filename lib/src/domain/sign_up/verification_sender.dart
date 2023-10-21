import 'package:formz/formz.dart';

/// Validation errors for the [verification sender] [FormzInput].
enum VerificationSenderError {
  /// Generic invalid error.
  invalid
}

/// {@template verification sender}
/// Form input for a verification sender input.
/// {@endtemplate}
class VerificationSender extends FormzInput<String, VerificationSenderError> {
  /// {@macro verification sender}
  const VerificationSender.pure() : super.pure('');

  static final _phoneRegExp = RegExp(r'^[0-9]{10}');

  static final _emailRegex = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]');

  /// {@macro verification sender}
  const VerificationSender.dirty([String value = '']) : super.dirty(value);

  @override
  VerificationSenderError? validator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (_phoneRegExp.hasMatch(value) && value.length == 10) {
        return null;
      } else if (_emailRegex.hasMatch(value) && value.length > 5) {
        return null;
      } else {
        return VerificationSenderError.invalid;
      }
    } else {
      return VerificationSenderError.invalid;
    }
  }
}
