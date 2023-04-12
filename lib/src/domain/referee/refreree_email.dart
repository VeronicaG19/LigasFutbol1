import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RefereeEmailValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RefereeEmail extends FormzInput<String, RefereeEmailValidationError> {
  /// {@macro Address}
  const RefereeEmail.pure() : super.pure('');

  /// {@macro  Address}
  const RefereeEmail.dirty([String value = '']) : super.dirty(value);

  @override
  RefereeEmailValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RefereeEmailValidationError.invalid;
  }
}