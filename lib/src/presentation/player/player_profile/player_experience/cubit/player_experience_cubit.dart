import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/validators/simple_text_validator.dart';
import '../../../../../domain/player_experience/entity/player_experience.dart';
import '../../../../../domain/player_experience/service/i_player_experience_service.dart';

part 'player_experience_state.dart';

@Injectable()
class PlayerExperienceCubit extends Cubit<PlayerExperienceState> {
  PlayerExperienceCubit(this._service) : super(const PlayerExperienceState());

  final IPlayerExperienceService _service;

  void onTitleChanged(String value) {
    final title = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description]),
    ));
  }

  void onDescriptionChanged(String value) {
    final description = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description, state.title]),
    ));
  }

  void onLeagueChanged(String value) {
    emit(state.copyWith(
      league: value,
    ));
  }

  void onCategoryChanged(String value) {
    emit(state.copyWith(
      category: value,
    ));
  }

  void onTournamentChanged(String value) {
    emit(state.copyWith(
      tournament: value,
    ));
  }

  void onTeamChanged(String value) {
    emit(state.copyWith(
      team: value,
    ));
  }

  Future<void> onSubmitNewExperience(int personId) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _service.createExperience(
      PlayerExperience.empty.copyWith(
        experiencesTitle: state.title.value,
        experiencesDescription: state.description.value,
        leagueName: state.league,
        teamCategory: state.category,
        tournament: state.tournament,
        team: state.team,
        partyId: personId,
        experiencesPosition: 1,
      ),
    );
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            status: FormzStatus.submissionFailure)),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)));
  }
}
