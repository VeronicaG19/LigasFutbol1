import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum CategoryNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class CategoryName extends FormzInput<String, CategoryNameValidationError> {
  /// {@macro password}
  /// inicializar el objeto cuando este vacio
  /// siempre
  const CategoryName.pure() : super.pure('');

  /// {@macro password}
  /// pasar un parametro para inicializar la clase
  const CategoryName.dirty([String value = '']) : super.dirty(value);

  @override
  CategoryNameValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : CategoryNameValidationError.invalid;
  }
}
