import 'package:formz/formz.dart';

enum TypeMatchTeamValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Address name}
/// Form input for a Address input.
/// {@endtemplate}
class TypeMatchTeam extends FormzInput<String, TypeMatchTeamValidationError> {
  /// {@macro Address}
  const TypeMatchTeam.pure() : super.pure('');

  /// {@macro  Address}
  const TypeMatchTeam.dirty([String value = '']) : super.dirty(value);

  @override
  TypeMatchTeamValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : TypeMatchTeamValidationError.invalid;
  }
}
