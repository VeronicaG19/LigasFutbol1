import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/create_team/create_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/matches_by_team/matches_by_team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/team_league_manager_dto/team_league_manager_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/models/common_pageable_response.dart';
import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../../team_tournament/entity/team_tournament.dart';
import '../entity/team.dart';
import 'i_team_repository.dart';

@LazySingleton(as: ITeamRepository)
class TeamRepositoryImpl implements ITeamRepository {
  final ApiClient _apiClient;

  TeamRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Team>> getRequestTeamByLeague(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getRequestTeamByLeagueEndpoint/N/$leagueId",
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getsAllTeamsPlayer(int partyId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getsAllTeamsPlayerEndpoint/$partyId",
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getTransferHistoryPlayer(int partyId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getTransferHistoryPlayerEndpoint/$partyId",
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<CommonPageableResponse<Team>> getAllTeams(
      {int? page,
      int? size,
      int? categoryId,
      String? requestPlayers,
      String? teamName}) {
    final data = <String, dynamic>{};
    if (page != null) {
      data.addAll({'page': page});
    }
    data.addAll({'size': size ?? 10});
    data.addAll({'categoryId': categoryId});
    data.addAll({'requestPlayers': requestPlayers});
    data.addAll({'teamName': teamName});
    return _apiClient.network
        .getData(
            endpoint: getAllPagedTeamsEndpoint,
            queryParams: data,
            converter: (response) => CommonPageableResponse.fromJson(
                json: response, converter: Team.fromJson, item: 'teams'))
        .validateResponse();
    // return _apiClient.network
    //     .getCollectionData(
    //         endpoint: getAllPagedTeamsEndpoint,
    //         queryParams: {'page': 0, 'size': 3},
    //         converter: SearchTeam.fromJson)
    //     .validateResponse();
  }

  @override
  RepositoryResponse<CommonPageableResponse<TeamLeagueManagerDTO>>
      getAllTeamsByLeague({int? page, int? size, int? leagueId}) {
    final data = <String, dynamic>{};
    if (page != null) {
      data.addAll({'page': page});
    }
    data.addAll({'size': size ?? 10});
    return _apiClient.network
        .getData(
            endpoint: getAllPagedTeamsByLeagueEndpoint + '/$leagueId',
            queryParams: data,
            converter: (response) => CommonPageableResponse.fromJson(
                json: response,
                converter: TeamLeagueManagerDTO.fromJson,
                item: 'teamsByLeagueVs'))
        .validateResponse();
    // return _apiClient.network
    //     .getCollectionData(
    //         endpoint: getAllPagedTeamsEndpoint,
    //         queryParams: {'page': 0, 'size': 3},
    //         converter: SearchTeam.fromJson)
    //     .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getTeamsLeagueId(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "${getTeamsLeagueIdEndpoint}/$leagueId",
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getListTeams() {
    return _apiClient.network
        .getCollectionData(
            endpoint: getAllteamsPresident, converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Team> createTeamPresiden(Team team) {
    return _apiClient.network
        .postData(
            endpoint: createTeamPresident,
            data: team.toJson(),
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Team> updateTeamPresiden(Team team) {
    return _apiClient.network
        .updateData(
            endpoint: updateTeamPresident,
            data: team.toJson(),
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Team> detailTeamByIdTeamPresiden(int teamId) {
    return _apiClient.network
        .getData(
            endpoint: '$getDetailTeamPresident$teamId',
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getListTeamsByCategoryId(int categoryId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTeamByCategoryPresident$categoryId',
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<void> deleteTeamPresiden(int teamId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$deleteTeamPresident$teamId', converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getTeamsNotSuscribedOnTournament(
      int tournamnetId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTeamsToSuscribe/$tournamnetId',
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> createTeam(CreateTeamDTO team) {
    return _apiClient.network
        .postData(
            endpoint: createTeamPresident,
            data: team.toJson(),
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateTeam(CreateTeamDTO team) {
    return _apiClient.network
        .updateData(
            endpoint: createTeamPresident,
            data: team.toJson(),
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _apiClient.network
        .getData(
            converter: ResgisterCountInterface.fromJson,
            endpoint: createTeamPresident + "/countTeams/$leagueId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Team>> getTeamsFindByRepresentant(int personId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getTeamsFindByRepresentantEndpoint/$personId",
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Team> getDetailTeamByIdTeam(int teamId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
            endpoint: '$getTeamByTeamId/$teamId',
            converter: Team.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<MatchesByTeamDTO>> getMatchesByTeam(int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getMatchesByTeamEndpoint/$teamId",
            converter: MatchesByTeamDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<TeamTournament>> getTeamClassifiedByTournament(
      int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTeamClassifiedByTournamentId/$tournamentId',
            converter: TeamTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Team> updateTeamByTeamService(Team team) =>
      _apiClient.updateData(
          endpoint: teamServiceTeamsEndpoint,
          data: team.toJson(),
          converter: Team.fromJson);
}
