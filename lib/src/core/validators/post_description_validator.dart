import 'package:formz/formz.dart';

/// Validation errors for [SimpleText] [FormzInput].
enum PostDescriptionValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for SimpleText.
/// {@endtemplate}
class PostDescriptionValidator
    extends FormzInput<String, PostDescriptionValidationError> {
  /// {@macro SimpleText}
  const PostDescriptionValidator.pure() : super.pure('');

  /// {@macro SimpleText}
  const PostDescriptionValidator.dirty([String value = ''])
      : super.dirty(value);

  @override
  PostDescriptionValidationError? validator(String? value) {
    return value != null && value.trim().length > 45 && value.trim().isNotEmpty
        ? null
        : PostDescriptionValidationError.invalid;
  }
}
