import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/entity/scoring_table.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';

import '../../../../../../domain/scoring_table/dto/scoring_table_dto.dart';
import '../../../../../../domain/scoring_table/goals_scored.dart';
import '../../../../../../domain/scoring_table/service/i_scoring_table_service.dart';
import '../../../../../../domain/team_player/dto/player_into_team_dto.dart';
import '../../../../../../domain/team_player/service/i_team_player_service.dart';
import '../../../../../../domain/team_tournament/service/i_team_tournament_service.dart';
import '../../../../../../domain/tournament/entity/tournament.dart';

part 'scoring_table_state.dart';

@injectable
class ScoringTableCubit extends Cubit<ScoringTableState> {
  ScoringTableCubit(
      this._service, this._teamTournamentService, this._teamPlayerService)
      : super(const ScoringTableState());

  final IScoringTableService _service;
  final ITeamTournamentService _teamTournamentService;
  final ITeamPlayerService _teamPlayerService;

  Future<void> getScoringTableData({required Tournament tournament}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getScoringTable(tournament.tournamentId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getTeamsTournaments(tournamentId: tournament.tournamentId!);
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          listScoringTableData: r,
          scoringObj: ScoringTable.empty,
          tournament: tournament));
    });
  }

  Future<void> getTeamsTournaments({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamTournamentService
        .getTeamTournamentByTournament(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, listOfTeams: r));
    });
  }

  Future<void> getPlayersForTeam(
      {required TeamTournament teamTournament}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.playersGetting));
    final response = await _teamPlayerService
        .getPlayersIntoTeam(teamTournament.teamId!.teamId!);
    response.fold((l) => print(l), (r) {
      int pending = teamTournament.goalsInFavor ??
          0 - getPendingGoals(teamTournament.teamTournamentId!);
      emit(state.copyWith(
          palyersList: r,
          goalsPending: pending,
          screenStatus: ScreenStatus.playersGeted));
    });
  }

  int getPendingGoals(int teamTournamentId) {
    int pendingGoals = 0;
    for (var element in state.listScoringTableData) {
      if (element.teamTournamentId == teamTournamentId) {
        pendingGoals = element.numberGoalsScored! + pendingGoals;
      }
    }
    return pendingGoals;
  }

  Future<void> saveScoringTable() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ScoringTable scoring = state.scoringObj.copyWith(
        enabledFlag: 'Y', numberGoalsScored: int.parse(state.goals.value));
    if (scoring.teamTournamentId == null || scoring.partyId == null) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return;
    }

    final response = await _service.createScoringTablePresident(scoring);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage)),
              getScoringTableData(tournament: state.tournament)
            }, (r) {
      print(state.tournament.tournamentId);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          screenStatus: ScreenStatus.loaded));
      getScoringTableData(tournament: state.tournament);
    });
  }

  Future<void> addScoring() async {
    emit(state.copyWith(isAddScoring: !state.isAddScoring));
  }

  Future<void> onChangeTeam(TeamTournament teamTournament) async {
    emit(state.copyWith(
        scoringObj:
            state.scoringObj.copyWith(teamTournamentId: teamTournament)));
  }

  Future<void> onChangePlayer(int partyId) async {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        scoringObj: state.scoringObj.copyWith(partyId: partyId)));
  }

  void onChangeGoals(String value) {
    final goals = GoalScored.dirty(value);
    emit(state.copyWith(status: Formz.validate([goals]), goals: goals));
  }
}
