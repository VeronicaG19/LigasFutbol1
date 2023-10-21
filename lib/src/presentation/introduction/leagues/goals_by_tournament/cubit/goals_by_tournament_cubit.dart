import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/goals_by_tournament/goals_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'goals_by_tournament_state.dart';

@injectable
class GoalsByTournamentCubit extends Cubit<GoalsByTournamentState> {
  GoalsByTournamentCubit(this._tournamentService)
      : super(const GoalsByTournamentState());
  final ITournamentService _tournamentService;
  Future<void> getFindByNameAndCategory(
      {required Category category, required Tournament tournament}) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    final response = await _tournamentService.getFindByNameAndCategory(
        category.categoryId!, tournament.tournamentName!,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getGoalsByTournament(tournamentId: r.tournamentId!);
    });
  }

  Future<void> getGoalsByTournament({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _tournamentService.getGoalsTournamentId(tournamentId,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      for (final i in r) {
        print('jugador -> ${i.player} Goles -> ${i.goals}');
      }
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, goalsTournament: r));
    });
  }
}
