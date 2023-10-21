import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum MinAgeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class MinAge extends FormzInput<int, MinAgeValidationError> {
  /// {@macro password}
  const MinAge.pure() : super.pure(0);

  /// {@macro password}
  const MinAge.dirty([int value = 0]) : super.dirty(value);

  @override
  MinAgeValidationError? validator(int? value) {
    return value! > 0 ? null : MinAgeValidationError.invalid;
  }
}
