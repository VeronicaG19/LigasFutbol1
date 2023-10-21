import 'package:formz/formz.dart';

enum MinutValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class Minut extends FormzInput<String, MinutValidationError> {
  /// {@macro Address}
  const Minut.pure() : super.pure('');

  /// {@macro  Address}
  const Minut.dirty([String value = '']) : super.dirty(value);

  @override
  MinutValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true && int.parse(value!.trim()) <= 150
        ? null
        : MinutValidationError.invalid;
  }
}
