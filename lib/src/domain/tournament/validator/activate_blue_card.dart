import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum ActiveBlueCardValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class ActiveBlueCard extends FormzInput<String, ActiveBlueCardValidationError> {
  /// {@macro Address}
  const ActiveBlueCard.pure() : super.pure('');

  /// {@macro  Address}
  const ActiveBlueCard.dirty([String value = '']) : super.dirty(value);

  @override
  ActiveBlueCardValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : ActiveBlueCardValidationError.invalid;
  }
}