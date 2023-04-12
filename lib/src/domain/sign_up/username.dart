import 'package:formz/formz.dart';

/// Validation errors for the [Username] [FormzInput].
enum UserNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template username}
/// Form input for a username input.
/// {@endtemplate}
class Username extends FormzInput<String, UserNameValidationError> {
  /// {@macro username}
  const Username.pure() : super.pure('');

  /// {@macro username}
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UserNameValidationError.invalid;
  }
}
