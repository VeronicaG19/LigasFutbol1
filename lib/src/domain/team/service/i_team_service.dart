import 'package:ligas_futbol_flutter/src/domain/team/dto/create_team/create_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/team_league_manager_dto/team_league_manager_dto.dart';

import '../../../core/models/common_pageable_response.dart';
import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../../team_tournament/entity/team_tournament.dart';
import '../dto/matches_by_team/matches_by_team.dart';
import '../entity/team.dart';

abstract class ITeamService {
  RepositoryResponse<List<Team>> getRequestTeamByLeague(int leagueId);
  RepositoryResponse<List<Team>> getsAllTeamsPlayer(int partyId);
  RepositoryResponse<List<Team>> getTransferHistoryPlayer(int partyId);
  RepositoryResponse<CommonPageableResponse<Team>> getAllTeams(
      {int? page,
      int? size,
      int? categoryId,
      String? requestPlayers,
      String? teamName});
  RepositoryResponse<CommonPageableResponse<TeamLeagueManagerDTO>>
      getAllTeamsByLeague({int? page, int? size, int? leagueId});
  RepositoryResponse<List<Team>> getTeamsLeagueId(int leagueId);
  RepositoryResponse<List<Team>> getTeamsFindByRepresentant(int personId);
  Future<List<Team>> getManagerTeams(int personId);

  ///Get lis of a teams
  ///
  /// * @return [List of Team]
  RepositoryResponse<List<Team>> getListTeams();

  /// Create a team
  ///
  /// * @return [Team]
  RepositoryResponse<Team> createTeamPresiden(Team team);
  RepositoryResponse<String> createTeam(CreateTeamDTO team);
  RepositoryResponse<String> updateTeam(CreateTeamDTO team);

  /// Update a team
  ///
  /// * @return [Team]
  RepositoryResponse<Team> updateTeamPresiden(Team team);

  /// Detail team
  ///
  /// * @return [Team]
  /// * @param [teamId]
  RepositoryResponse<Team> detailTeamByIdTeamPresiden(int teamId);

  ///Get lis of a teams
  ///
  /// * @return [List of Team ]
  /// * @param [categoryId]
  RepositoryResponse<List<Team>> getListTeamsByCategoryId(int categoryId);

  /// delete a team
  ///
  /// * @param [teamId]
  RepositoryResponse<void> deleteTeamPresiden(int teamId);

  /// Get teams not suscribed on tournament
  ///
  ///* @param [tournamentId]
  ///* @return [List of Team]
  RepositoryResponse<List<Team>> getTeamsNotSuscribedOnTournament(
      int tournamnetId);

  ///Get count teams by league
  ///
  /// * @param [leagueId]
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId);

  /// Get detailteam by id
  ///
  /// * @return [Team]
  /// * @param [teamId]
  RepositoryResponse<Team> getDetailTeamByIdTeam(int teamId,
      {bool requiresAuthToken = true});

  RepositoryResponse<List<MatchesByTeamDTO>> getMatchesByTeam(int teamId);

  RepositoryResponse<List<TeamTournament>> getTeamClassifiedByTournament(
      int tournamentId);
  RepositoryResponse<Team> updateTeamByTeamService(Team team);
}
