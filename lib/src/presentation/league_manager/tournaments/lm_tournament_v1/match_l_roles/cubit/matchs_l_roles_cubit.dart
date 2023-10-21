import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import '../../../../../../domain/matches/dto/match_team_matches_refree.dart/MatchTeamMatchesRefereeDTO.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/team/service/i_team_service.dart';
import '../../../../../../domain/team_matches/entity/team_matches.dart';
import '../../../../../../domain/team_tournament/entity/team_tournament.dart';

part 'matchs_l_roles_state.dart';

@injectable
class MatchesLRolesCubit extends Cubit<MatchesLRolesState> {
  MatchesLRolesCubit(this._teamService, this._service)
      : super(const MatchesLRolesState());

  final ITeamService _teamService;
  final IMatchesService _service;
  late final int _tournamentId;
  final List<TeamTournament> _teamList = [];
  late final List<List<TeamTournament>> _roundsList;

  Future<void> getTournamentTeams({final int? tournamentId}) async {
    _tournamentId = tournamentId ?? 0;

    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response =
        await _teamService.getTeamClassifiedByTournament(_tournamentId);

    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _teamList.addAll(r);
      _defineTeamLists();
    });
  }

  void _defineTeamLists() {
    final int roundCount = _teamList.length ~/ 2;
    final roundDescription = _defineRound(roundCount);
    _roundsList = List<List<TeamTournament>>.generate(
        _teamList.length, (index) => _teamList);

    emit(state.copyWith(
        round: roundDescription,
        roundCount: roundCount,
        listOfTeams: _roundsList,
        tmsSelected:
            List.generate(_teamList.length, (index) => TeamTournament.empty),
        screenStatus: BasicCubitScreenState.loaded));
  }

  void onSelectTeam(final TeamTournament? team, final int indexList) {
    List<TeamTournament> selectedTeams = [];
    selectedTeams.addAll(state.tmsSelected);
    if (team == selectedTeams[indexList]) return;
    selectedTeams
        .replaceRange(indexList, indexList + 1, [team ?? TeamTournament.empty]);

    List<List<TeamTournament>> teamsList =
        List<List<TeamTournament>>.generate(_teamList.length, (index) {
      List<TeamTournament> list = [];
      list.addAll(state.listOfTeams[indexList]);
      if (index == indexList) {
        return list;
      } else {
        list.addAll(state.listOfTeams[index]);
        List<TeamTournament> aux = list.toSet().toList();
        aux.removeWhere((element) => team == element);
        return aux;
      }
    });
    emit(state.copyWith(listOfTeams: teamsList, tmsSelected: selectedTeams));
  }

  void onCleanList() {
    emit(state.copyWith(
        listOfTeams: _roundsList,
        tmsSelected:
            List.generate(_teamList.length, (index) => TeamTournament.empty),
        screenStatus: BasicCubitScreenState.loaded));
  }

  Future<void> onSaveEditRoles() async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.validating));
    for (final e in state.tmsSelected) {
      if (e == TeamTournament.empty) {
        emit(state.copyWith(screenStatus: BasicCubitScreenState.emptyData));
        return;
      }
    }
    List<MatchTeamMatchesRefereeDTO> encounters = [];
    for (int i = 0; i < state.roundCount; i++) {
      final local = TeamMatche(
        teamTournamentId: TeamTournament(
            teamTournamentId: state.tmsSelected[i + i].teamTournamentId),
      );
      final guest = TeamMatche(
        teamTournamentId: TeamTournament(
            teamTournamentId: state.tmsSelected[i + (i + 1)].teamTournamentId),
      );
      encounters.add(
          MatchTeamMatchesRefereeDTO(teamMatchL: local, teamMatchV: guest));
    }
    emit(state.copyWith(
        screenStatus: BasicCubitScreenState.submissionInProgress));
    final response = await _service.createRolesClass(encounters, _tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.submissionFailure,
            errorMessage: l.errorMessage)),
        (r) => {
              emit(state.copyWith(
                  screenStatus: BasicCubitScreenState.submissionSuccess))
            });
  }

  String _defineRound(final int roundCount) {
    switch (roundCount) {
      case 1:
        return 'Final';
      case 2:
        return 'Semifinal';
      case 4:
        return 'Cuartos';
      case 8:
        return '8VOS';
      case 16:
        return '16VOs';
      case 32:
        return '32VOs';
      default:
        return 'Liguilla';
    }
  }
}
