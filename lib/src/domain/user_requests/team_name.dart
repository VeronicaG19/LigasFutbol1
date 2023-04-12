import 'package:formz/formz.dart';

enum TeamNameValidationError { invalid }

class TeamName extends FormzInput<String, TeamNameValidationError> {
  const TeamName.pure() : super.pure('');

  const TeamName.dirty([String value = '']) : super.dirty(value);

  @override
  TeamNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TeamNameValidationError.invalid;
  }

}