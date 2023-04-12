import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum ThirdValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Third extends FormzInput<String, ThirdValidationError> {
  /// {@macro Address}
  const Third.pure() : super.pure('');

  /// {@macro  Address}
  const Third.dirty([String value = '']) : super.dirty(value);

  @override
  ThirdValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : ThirdValidationError.invalid;
  }
}