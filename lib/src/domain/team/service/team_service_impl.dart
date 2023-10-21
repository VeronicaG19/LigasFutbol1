import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/create_team/create_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/matches_by_team/matches_by_team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/team_league_manager_dto/team_league_manager_dto.dart';

import '../../../core/models/common_pageable_response.dart';
import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../../team_tournament/entity/team_tournament.dart';
import '../entity/team.dart';
import '../repository/i_team_repository.dart';
import 'i_team_service.dart';

@LazySingleton(as: ITeamService)
class TeamServiceImpl implements ITeamService {
  final ITeamRepository _repository;

  TeamServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Team>> getRequestTeamByLeague(int leagueId) {
    return _repository.getRequestTeamByLeague(leagueId);
  }

  @override
  RepositoryResponse<List<Team>> getsAllTeamsPlayer(int partyId) {
    return _repository.getsAllTeamsPlayer(partyId);
  }

  @override
  RepositoryResponse<List<Team>> getTransferHistoryPlayer(int partyId) {
    return _repository.getTransferHistoryPlayer(partyId);
  }

  @override
  RepositoryResponse<CommonPageableResponse<Team>> getAllTeams(
      {int? page,
      int? size,
      int? categoryId,
      String? requestPlayers,
      String? teamName}) {
    return _repository.getAllTeams(
        page: page,
        size: size,
        categoryId: categoryId,
        requestPlayers: requestPlayers,
        teamName: teamName);
  }

  @override
  RepositoryResponse<CommonPageableResponse<TeamLeagueManagerDTO>>
      getAllTeamsByLeague({int? page, int? size, int? leagueId}) {
    return _repository.getAllTeamsByLeague(
        page: page, size: size, leagueId: leagueId);
  }

  @override
  RepositoryResponse<List<Team>> getListTeams() {
    return _repository.getListTeams();
  }

  @override
  RepositoryResponse<Team> createTeamPresiden(Team team) {
    return _repository.createTeamPresiden(team);
  }

  @override
  RepositoryResponse<Team> updateTeamPresiden(Team team) {
    return _repository.updateTeamPresiden(team);
  }

  @override
  RepositoryResponse<Team> detailTeamByIdTeamPresiden(int teamId) {
    return _repository.detailTeamByIdTeamPresiden(teamId);
  }

  @override
  RepositoryResponse<List<Team>> getListTeamsByCategoryId(int categoryId) {
    return _repository.getListTeamsByCategoryId(categoryId);
  }

  @override
  RepositoryResponse<void> deleteTeamPresiden(int teamId) {
    return _repository.deleteTeamPresiden(teamId);
  }

  @override
  RepositoryResponse<List<Team>> getTeamsNotSuscribedOnTournament(
      int tournamnetId) {
    return _repository.getTeamsNotSuscribedOnTournament(tournamnetId);
  }

  @override
  RepositoryResponse<List<Team>> getTeamsLeagueId(int leagueId) {
    return _repository.getTeamsLeagueId(leagueId);
  }

  @override
  RepositoryResponse<String> createTeam(CreateTeamDTO team) {
    return _repository.createTeam(team);
  }

  @override
  RepositoryResponse<String> updateTeam(CreateTeamDTO team) {
    return _repository.updateTeam(team);
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _repository.getCountByLeagueId(leagueId);
  }

  @override
  RepositoryResponse<List<Team>> getTeamsFindByRepresentant(
      int personId) async {
    return _repository.getTeamsFindByRepresentant(personId);
  }

  @override
  Future<List<Team>> getManagerTeams(int personId) async {
    final request = await _repository.getTeamsFindByRepresentant(personId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<Team> getDetailTeamByIdTeam(int teamId,
      {bool requiresAuthToken = true}) {
    return _repository.getDetailTeamByIdTeam(teamId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<MatchesByTeamDTO>> getMatchesByTeam(int teamId) {
    return _repository.getMatchesByTeam(teamId);
  }

  @override
  RepositoryResponse<List<TeamTournament>> getTeamClassifiedByTournament(
      int tournamentId) {
    return _repository.getTeamClassifiedByTournament(tournamentId);
  }

  @override
  RepositoryResponse<Team> updateTeamByTeamService(Team team) =>
      _repository.updateTeamByTeamService(team);
}
