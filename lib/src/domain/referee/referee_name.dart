import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RefereeNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RefereeName extends FormzInput<String, RefereeNameValidationError> {
  /// {@macro Address}
  const RefereeName.pure() : super.pure('');

  /// {@macro  Address}
  const RefereeName.dirty([String value = '']) : super.dirty(value);

  @override
  RefereeNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : RefereeNameValidationError.invalid;
  }
}