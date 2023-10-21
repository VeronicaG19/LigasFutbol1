import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/dto/team_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';

import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../teams_tournamens/card_team_obj.dart';

part 'teams_state.dart';

@injectable
class TeamsLMCubit extends Cubit<TeamsLMState> {
  TeamsLMCubit(this._service, this._teamTournamentService)
      : super(TeamsLMState());

  final ITeamService _service;
  final ITeamTournamentService _teamTournamentService;

  Future<void> getTeamsTournamentByTournament(
      {required Tournament tournament}) async {
    print('-------->getTeamsTournamentByTournament<---------');
    emit(state.copyWith(
        screenStatus: ScreenStatus.loading, tournament: tournament));
    final response = await _teamTournamentService
        .getTeamTournamentByTournament(tournament.tournamentId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print(r.length);
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, teamsTournament: r));
    });
  }

  Future<void> getTournamentTeamDataBytournament(
      {required Tournament tournament}) async {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loading, tournament: tournament));
    final response = await _teamTournamentService
        .getTournamentTeamDataBytournament(tournament.tournamentId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print(r.length);
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, teamsTournamentDto: r));
    });
  }

  Future<void> getTeamsTosuscribeTournament() async {
    emit(state.copyWith(screenStatus: ScreenStatus.teamsGetting));
    final response = await _service
        .getTeamsNotSuscribedOnTournament(state.tournament.tournamentId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(countSelected: 0));
      getCountInscribedTeams(state.tournament.tournamentId!);
      createCradsForTeams(r);
    });
  }

  Future<void> createCradsForTeams(List<Team> tems) async {
    List<CardTeamOBJ> cardTeamsSlc = [];
    tems.forEach((element) {
      CardTeamOBJ crdTeam = CardTeamOBJ(
          imageTeam: element.teamPhotoId?.document ?? '',
          isSelected: false,
          teamName: element.teamName,
          teamId: element.teamId);
      cardTeamsSlc.add(crdTeam);
    });
    emit(state.copyWith(
        screenStatus: ScreenStatus.teamsGetted,
        teams: tems,
        cardTeamsSlc: cardTeamsSlc));
  }

  Future<void> markTeamToSuscribe(bool val, int index) async {
    int cont = state.countSelected;
    final cardsteams = state.cardTeamsSlc;
    final card = cardsteams[index];

    emit(state.copyWith(cardTeamsSlc: [], countSelected: 0));
    cardsteams.removeAt(index);

    print(
        '$cont  < ${state.tournament.maxTeams! - state.inscribedTeams.coundt1!}');

    if (cont < (state.tournament.maxTeams! - state.inscribedTeams.coundt1!)) {
      cont = val ? (cont + 1) : (cont - 1);
      cardsteams.insert(index, card.copyWith(isSelected: val));
    } else {
      cont = val ? cont : (cont - 1);
      cardsteams.insert(index, card.copyWith(isSelected: false));
    }

    emit(state.copyWith(cardTeamsSlc: cardsteams, countSelected: cont));
  }

  Future<void> getCountInscribedTeams(int tournamnetId) async {
    final response =
        await _teamTournamentService.getTeamcounTorunament(tournamnetId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(inscribedTeams: r));
    });
  }

  Future<void> subscribeTeams() async {
    emit(state.copyWith(screenStatus: ScreenStatus.teamsGetting));
    List<TeamTournament> teamsToInscribe = [];
    if (state.countSelected > 0) {
      state.cardTeamsSlc.forEach((card) {
        if (card.isSelected!) {
          int index = state.teams
              .indexWhere((element) => element.teamId == card.teamId);
          Team team = state.teams[index];
          TeamTournament ttm =
              TeamTournament(teamId: team, tournamentId: state.tournament);
          teamsToInscribe.add(ttm);
        }
      });

      final response = await _teamTournamentService
          .inscribeTeamOnATournament(teamsToInscribe);
      response.fold((l) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));
        //getTeamsTournamentByTournament(tournament: state.tournament);
      }, (r) {
        //getTeamsTournamentByTournament(tournament: state.tournament);
      });
      emit(state.copyWith(screenStatus: ScreenStatus.success));
    } else {
      emit(state.copyWith(screenStatus: ScreenStatus.success));
    }
    getTournamentTeamDataBytournament(tournament: state.tournament);
  }

  Future<void> unSuscribeTeams(int teamTournamentId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.teamsGetting));
    final response = await _teamTournamentService
        .unsubscribeTeamTournament(teamTournamentId);
    response.fold((l) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));
      //getTeamsTournamentByTournament(tournament: state.tournament);
    }, (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.success));
      getTournamentTeamDataBytournament(tournament: state.tournament);
      //getTeamsTournamentByTournament(tournament: state.tournament);
      // emit(state.copyWith(screenStatus: ScreenStatus.teamsGetted));
    });
  }
}
