import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum RoundTripValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class RoundTrip extends FormzInput<String, RoundTripValidationError> {
  /// {@macro Address}
  const RoundTrip.pure() : super.pure('');

  /// {@macro  Address}
  const RoundTrip.dirty([String value = '']) : super.dirty(value);

  @override
  RoundTripValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : RoundTripValidationError.invalid;
  }
}