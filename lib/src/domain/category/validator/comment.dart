import 'package:formz/formz.dart';

/// Validation errors for the [password] [FormzInput].
enum CommentValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for a password input.
/// {@endtemplate}
class Comment extends FormzInput<String, CommentValidationError> {
  /// {@macro password}
  const Comment.pure() : super.pure('');

  /// {@macro password}
  const Comment.dirty([String value = '']) : super.dirty(value);

  @override
  CommentValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : CommentValidationError.invalid;
  }
}
