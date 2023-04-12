import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DormForredValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DormForred extends FormzInput<String, DormForredValidationError> {
  /// {@macro Address}
  const DormForred.pure() : super.pure('');

  /// {@macro  Address}
  const DormForred.dirty([String value = '']) : super.dirty(value);

  @override
  DormForredValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DormForredValidationError.invalid;
  }
}