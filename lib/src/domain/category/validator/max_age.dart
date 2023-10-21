import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum MaxAgeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class MaxAge extends FormzInput<int, MaxAgeValidationError> {
  /// {@macro password}
  const MaxAge.pure() : super.pure(0);

  /// {@macro password}
  const MaxAge.dirty([int value = 0]) : super.dirty(value);

  @override
  MaxAgeValidationError? validator(int? value) {
    return value! > 0 ? null : MaxAgeValidationError.invalid;
  }
}
