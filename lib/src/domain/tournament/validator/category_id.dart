import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum CategoryIdValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class CategoryId extends FormzInput<String, CategoryIdValidationError> {
  /// {@macro Address}
  const CategoryId.pure() : super.pure('');

  /// {@macro  Address}
  const CategoryId.dirty([String value = '']) : super.dirty(value);

  @override
  CategoryIdValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true ? null : CategoryIdValidationError.invalid;
  }
}