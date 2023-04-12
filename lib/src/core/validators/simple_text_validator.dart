import 'package:formz/formz.dart';

/// Validation errors for [SimpleText] [FormzInput].
enum SimpleTextValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for SimpleText.
/// {@endtemplate}
class SimpleTextValidator
    extends FormzInput<String, SimpleTextValidationError> {
  /// {@macro SimpleText}
  const SimpleTextValidator.pure() : super.pure('');

  /// {@macro SimpleText}
  const SimpleTextValidator.dirty([String value = '']) : super.dirty(value);

  @override
  SimpleTextValidationError? validator(String? value) {
    return value != null && value.trim().isNotEmpty
        ? null
        : SimpleTextValidationError.invalid;
  }
}
