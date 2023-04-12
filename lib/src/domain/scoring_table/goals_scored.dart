import 'package:formz/formz.dart';

/// Validation errors for the [GoalScored] [FormzInput].
enum GoalScoredValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template GoalScored}
/// Form input for a PositionPlayer input.
/// {@endtemplate}
class GoalScored extends FormzInput<String, GoalScoredValidationError> {
  /// {@macro GoalScored}
  const GoalScored.pure() : super.pure('');

  /// {@macro PositionPlayer}
  const GoalScored.dirty([String value = '']) : super.dirty(value);

  @override
  GoalScoredValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : GoalScoredValidationError.invalid;
  }
}