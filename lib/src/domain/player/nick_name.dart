import 'package:formz/formz.dart';

/// Validation errors for the [NickName] [FormzInput].
enum NickNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template nick name}
/// Form input for a nick name input.
/// {@endtemplate}
class NickName extends FormzInput<String, NickNameValidationError> {
  /// {@macro nuck name}
  const NickName.pure() : super.pure('');

  /// {@macro nick name}
  const NickName.dirty([String value = '']) : super.dirty(value);

  @override
  NickNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NickNameValidationError.invalid;
  }
}