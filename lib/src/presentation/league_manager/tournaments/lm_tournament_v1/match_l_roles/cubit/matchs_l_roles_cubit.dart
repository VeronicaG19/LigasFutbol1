import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../domain/matches/dto/match_team_matches_refree.dart/MatchTeamMatchesRefereeDTO.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/team/entity/team.dart';
import '../../../../../../domain/team/repository/i_team_repository.dart';
import '../../../../../../domain/team/service/i_team_service.dart';
import '../../../../../../domain/team_matches/entity/team_matches.dart';
import '../../../../../../domain/team_tournament/entity/team_tournament.dart';

part 'matchs_l_roles_state.dart';

@injectable
class MatchsLRolesCubit extends Cubit<MatchsLRolesState> {
  MatchsLRolesCubit(this._teamService, this._service)
      : super(MatchsLRolesState());

  final ITeamService _teamService;
  final IMatchesService _service;


  Future<void> getTeamsTournaments(
      {required int tournamentId, required int leagueId, required int numM}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService
        .getTeamClassifiedByTournament(tournamentId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, listOfTeams: r));
    });
    final rols = state.listRoleToGenerate;
    print("36 pamc ");
    List<MatchTeamMatchesRefereeDTO> roles = [];
    for (int i = 0; i < state.listOfTeams.length.toInt()~/2; i++) {
      roles.add(const MatchTeamMatchesRefereeDTO());
    }
    print(roles.length);
    print(numM);

    print ("rango antes de instanciar ${roles.length}");
    emit(state.copyWith(listRoleToGenerate: roles));
  }

  Future<void> onChangeTeamLocal(int index, TeamTournament teamL) async {
  MatchTeamMatchesRefereeDTO role = state.listRoleToGenerate[index]
        .copyWith(teamMatchL: TeamMatche(teamTournamentId: TeamTournament(teamTournamentId: teamL.teamTournamentId)));

    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);
    print(rols);
    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onChangeTeamVisit(int index, TeamTournament teamV) async {

    MatchTeamMatchesRefereeDTO role = state.listRoleToGenerate[index]
        .copyWith(teamMatchV: TeamMatche(teamTournamentId: TeamTournament(teamTournamentId: teamV.teamTournamentId)));
    print ("b");
    final rols = state.listRoleToGenerate;
    print ("c");
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    print(role);
    print("index $index - ${state.listRoleToGenerate}");
    rols.insert(index, role);
    //insert(index, role);
    print ("d");
    emit(state.copyWith(listRoleToGenerate: rols));
    print(state.listRoleToGenerate);
  }

  Future<void> onSaveEditRoles(int tournament) async {
    emit(state.copyWith(screenStatus: ScreenStatus.rolesCreating));
    final response = await _service.createRolesClass(state.listRoleToGenerate,tournament);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
            (r) => {emit(state.copyWith(screenStatus: ScreenStatus.rolesCreated))});
  }

}
