import 'package:formz/formz.dart';

enum PriceValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Price extends FormzInput<String, PriceValidationError> {
  /// {@macro Address}
  const Price.pure() : super.pure('');

  /// {@macro  Address}
  const Price.dirty([String value = '']) : super.dirty(value);

  @override
  PriceValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : PriceValidationError.invalid;
  }
}
