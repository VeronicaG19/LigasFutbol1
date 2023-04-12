import 'package:formz/formz.dart';

enum CategoryIdValidationError { invalid }

class CategoryId extends FormzInput<String, CategoryIdValidationError> {
  const CategoryId.pure() : super.pure('');

  const CategoryId.dirty([String value = '']) : super.dirty(value);

  @override
  CategoryIdValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CategoryIdValidationError.invalid;
  }

}