import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/service/i_field_service.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/interface/matches_by_tournament_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'matches_by_tournament_state.dart';

@injectable
class MatchesByTournamentCubit extends Cubit<MatchesByTournamentState> {
  MatchesByTournamentCubit(
      this._matchesService, this._fieldService, this._tournamentService)
      : super(const MatchesByTournamentState());

  final IMatchesService _matchesService;
  final IFieldService _fieldService;
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
      getMatchesByTournament(tournament: r);
    });
  }

  Future<void> getMatchesByTournament({required Tournament tournament}) async {
    final response = await _matchesService.getMatchesByTournament(
        tournament.tournamentId!,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, matchesList: r));
    });
    // pedro
    getTournamentFinishedStatus(tournamentId: tournament.tournamentId!);
    getTournamentChampion(tournamentId: tournament.tournamentId!);
  }

  Future<void> getFieldByMatchId({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _fieldService.getFieldByMatchId(teamId, requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, fieldData: r));
    });
  }

  Future<void> getTournamentFinishedStatus({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _tournamentService
        .getTournamentMatchesStatus(tournamentId, requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, statusTournament: r));
    });
  }

  Future<void> getTournamentChampion({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _tournamentService
        .getTournamentChampion(tournamentId, requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, nameCh: r.teamName));
    });
  }
}
