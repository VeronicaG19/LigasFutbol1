import 'package:formz/formz.dart';

enum LeagueIdValidationError { invalid }

class LeagueId extends FormzInput<String, LeagueIdValidationError> {
  const LeagueId.pure() : super.pure('');

  const LeagueId.dirty([String value = '']) : super.dirty(value);

  @override
  LeagueIdValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : LeagueIdValidationError.invalid;
  }

}