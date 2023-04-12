import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/field/entity/field.dart';
import '../../../../../../domain/field/service/i_field_service.dart';
import '../../../../../../domain/matches/dto/match_role_dto/match_role_dto.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../../domain/referee/service/i_referee_service.dart';
import '../../../../../../domain/team_tournament/entity/team_tournament.dart';
import '../../../../../../domain/team_tournament/service/i_team_tournament_service.dart';

part 'matchs_roles_state.dart';

@injectable
class MatchsRolesCubit extends Cubit<MatchsRolesState> {
  MatchsRolesCubit(this._service, this._teamTournamentService,
      this._refereeService, this._fieldService)
      : super(MatchsRolesState());

  final IMatchesService _service;
  final ITeamTournamentService _teamTournamentService;
  final IRefereeService _refereeService;
  final IFieldService _fieldService;

  Future<void> addRole() async {
    MatchRoleDTO role =
        MatchRoleDTO(roundNumber: state.nextRoundNumber.coundt1);
    final rols = state.listRoleToGenerate;
    List<MatchRoleDTO> roles = [];
    rols.forEach((element) {
      roles.add(element);
    });
    roles.add(role);
    emit(state.copyWith(listRoleToGenerate: roles));
  }

  Future<void> removeRole() async {
    final rols = state.listRoleToGenerate;
    if (rols.length > 0) {
      List<MatchRoleDTO> roles = [];
      rols.forEach((element) {
        roles.add(element);
      });
      roles.removeLast();
      emit(state.copyWith(listRoleToGenerate: roles));
    }
  }

  Future<void> getNetxRoundNumber({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getNextRound(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, nextRoundNumber: r));
    });
  }

  Future<void> getTeamsTournaments(
      {required int tournamentId, required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamTournamentService
        .getTeamTournamentByTournament(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getNetxRoundNumber(tournamentId: tournamentId);
      loadReferee(leagueId: leagueId);
      loadfields(leagueId: leagueId);
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, listOfTeams: r));
    });
  }

  Future<void> loadReferee({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _refereeService.getRefereeByLeague1(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, refereetList: r));
    });
  }

  Future<void> loadfields({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _fieldService.getFieldsByLeagueId(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, fieldtList: r));
    });
  }

  Future<void> onChangeTeamVisit(int index, TeamTournament teamV) async {
    MatchRoleDTO role = state.listRoleToGenerate[index]
        .copyWith(teamVisitId: teamV.teamTournamentId);
    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);

    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onChangeTeamLocal(int index, TeamTournament teamL) async {
    MatchRoleDTO role = state.listRoleToGenerate[index]
        .copyWith(teamLocalId: teamL.teamTournamentId);
    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);

    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onChangeDate(int index, DateTime date) async {
    MatchRoleDTO role =
        state.listRoleToGenerate[index].copyWith(dateMatch: date);
    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);

    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onChangeReferee(int index, RefereeByLeagueDTO referee) async {
    MatchRoleDTO role =
        state.listRoleToGenerate[index].copyWith(refereeId: referee.refereeId);
    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);

    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onChangeField(int index, Field field) async {
    MatchRoleDTO role =
        state.listRoleToGenerate[index].copyWith(fieldId: field.fieldId);
    final rols = state.listRoleToGenerate;
    //List<MatchRoleDTO> roles = [];
    rols.removeAt(index);
    rols.insert(index, role);

    emit(state.copyWith(listRoleToGenerate: rols));
  }

  Future<void> onSaveEditRoles() async {
    emit(state.copyWith(screenStatus: ScreenStatus.rolesCreating));
    final response = await _service.createRolesMatchs(state.listRoleToGenerate);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
        (r) => {emit(state.copyWith(screenStatus: ScreenStatus.rolesCreated))});
  }

  Future<void> onChangeRound(String round) async {
    int roundN = int.parse(round);
    if (roundN > 0) {
      final rols = state.listRoleToGenerate;
      List<MatchRoleDTO> roles = [];

      if (state.listRoleToGenerate.length > 0) {
        rols.forEach((element) {
          MatchRoleDTO role = element.copyWith(roundNumber: roundN);
          roles.add(role);
        });
      }

      emit(state.copyWith(
          listRoleToGenerate: roles,
          nextRoundNumber: state.nextRoundNumber.copyWith(coundt1: roundN)));
    }
  }
}
