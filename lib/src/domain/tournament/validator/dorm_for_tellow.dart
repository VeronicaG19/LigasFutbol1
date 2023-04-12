import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum DormForYellowValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class DormForYellow extends FormzInput<String, DormForYellowValidationError> {
  /// {@macro Address}
  const DormForYellow.pure() : super.pure('');

  /// {@macro  Address}
  const DormForYellow.dirty([String value = '']) : super.dirty(value);

  @override
  DormForYellowValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : DormForYellowValidationError.invalid;
  }
}