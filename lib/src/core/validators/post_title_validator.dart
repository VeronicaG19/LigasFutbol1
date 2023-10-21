import 'package:formz/formz.dart';

/// Validation errors for [SimpleText] [FormzInput].
enum PostTitleValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for SimpleText.
/// {@endtemplate}
class PostTitleValidator extends FormzInput<String, PostTitleValidationError> {
  /// {@macro SimpleText}
  const PostTitleValidator.pure() : super.pure('');

  /// {@macro SimpleText}
  const PostTitleValidator.dirty([String value = '']) : super.dirty(value);

  @override
  PostTitleValidationError? validator(String? value) {
    return value != null && value.trim().isNotEmpty && value.trim().length > 15
        ? null
        : PostTitleValidationError.invalid;
  }
}
