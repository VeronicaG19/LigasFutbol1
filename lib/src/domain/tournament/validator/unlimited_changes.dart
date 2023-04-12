import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum UnlimitedChangesValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class UnlimitedChanges extends FormzInput<String, UnlimitedChangesValidationError> {
  /// {@macro Address}
  const UnlimitedChanges.pure() : super.pure('');

  /// {@macro  Address}
  const UnlimitedChanges.dirty([String value = '']) : super.dirty(value);

  @override
  UnlimitedChangesValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : UnlimitedChangesValidationError.invalid;
  }
}