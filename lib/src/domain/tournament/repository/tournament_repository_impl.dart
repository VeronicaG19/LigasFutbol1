import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/countResponse/entity/register_count_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/goals_by_tournament/goals_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/performance_by_tournament/performance_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_by_player/tournament_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_champion/tournament_champion_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../dto/tournament_by_team/tournament_by_team_dto.dart';
import '../entity/tournament.dart';
import 'i_tournament_repository.dart';

@LazySingleton(as: ITournamentRepository)
class TournamentRepositoryImpl implements ITournamentRepository {
  final ApiClient _apiClient;

  TournamentRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Tournament>> getTournamentByLeagueId(int leagueId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            converter: Tournament.fromJson,
            endpoint: getTournamentEndpoint + "/league/$leagueId")
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> getFindByNameAndCategory(
      int categoryId, String tournamentName,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
            converter: Tournament.fromJson,
            endpoint: getFindByNameAndCategoryEndpoint +
                "?categoryId=$categoryId&tournamentName=$tournamentName")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<ScoringTournamentDTO>> getScoringTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            converter: ScoringTournamentDTO.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint: "$getScoringTournamentIdEndpoint/$tournamentId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<GoalsTournamentDTO>> getGoalsTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            converter: GoalsTournamentDTO.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint: "$getGoalsTournamentIdEndpoint/$tournamentId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<TournamentByPlayer>> getTournamentByPlayer(
      int partyId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getTournamentByPlayerEndpoint/$partyId",
            converter: TournamentByPlayer.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<PerformanceByTournament>> getPerformanceByPlayer(
      int partyId, int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint:
                "$getPerformanceByPlayerEndpoint?partyId=$partyId&tournamentId=$tournamentId",
            converter: PerformanceByTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Tournament>> getTournamentsListPresidnt(
      int categoryId) {
    return _apiClient.network
        .getCollectionData(
            converter: Tournament.fromJson,
            endpoint: '$getTournamentsByCategoryPresident$categoryId')
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> createTournamentPresident(
      List<Tournament> tournament) {
    final data = jsonEncode(tournament);
    return _apiClient.network
        .postData(
            endpoint: createTournamentPresiden,
            data: {},
            dataAsString: data, //tournament.tojsonUpdateCreate(),
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> updateTournamentPresiden(
      Tournament tournament) {
    return _apiClient.network
        .updateData(
            endpoint: updateTournamentPresident,
            data: tournament.toJson(),
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> detailTournamentPresident(int tournamentId) {
    return _apiClient.network
        .getData(
            endpoint: '$getTournamentDetailPresident$tournamentId',
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> deleteTournamentPresident(int tournamentId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$deleteTournamentPresiden$tournamentId',
            converter: Tournament.fromJson)
        .validateResponse();
  }

  RepositoryResponse<List<Tournament>> getHistoricTournaments(int categoryId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$historicTournamentsEndpoint/$categoryId',
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Tournament>> getTournamentsListByLeagePresidnt(
      int leagueId) {
    //
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTournamentsByLeaguePresident$leagueId',
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Tournament> getCurrentTournament(int categoryId) {
    return _apiClient.network
        .getData(
            endpoint: '$getCurrentTournamentEndpoint$categoryId',
            converter: Tournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Tournament>> getAllTournamentByLeagueId(
      int leagueId) {
    return _apiClient.network
        .getCollectionData(
            converter: Tournament.fromJson,
            endpoint:
                getTournamentEndpoint + "/allTournamentsByLeague/$leagueId")
        .validateResponse();
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _apiClient.network
        .getData(
            converter: ResgisterCountInterface.fromJson,
            endpoint:
                getTournamentEndpoint + "/counttournamentsleague/$leagueId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<TournamentByTeamDTO>> getTeamTournamentsByTeamId(
      int teamId) {
    return _apiClient.network
        .getCollectionData(
            converter: TournamentByTeamDTO.fromJson,
            endpoint: "$getTeamTournaments$teamId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getAvailableTournamentsByTeamId(int teamId) {
    return _apiClient.network.getCollectionData(
        converter: GetOpenTournamentsInterface.fromJson,
        endpoint: "$getTournamentsByTeamAndLeague$teamId",
        queryParams: {
          "leagueId": "",
        }).validateResponse();
  }

  @override
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getTournamentsByTeamIdAndLeagueId(int teamId, {int? leagueId}) {
    return _apiClient.network.getCollectionData(
        converter: GetOpenTournamentsInterface.fromJson,
        endpoint: "$getTournamentsByTeamAndLeague$teamId",
        queryParams: {
          "leagueId": "$leagueId",
        }).validateResponse();
  }

  @override
  RepositoryResponse<TournamentChampionDTO> getTournamentChampion(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
            endpoint: '$getTournamentChampionEndpoint/$tournamentId',
            converter: TournamentChampionDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<TournamentChampionDTO> tournamentFinished(
      int tournamentId) {
    return _apiClient.network
        .updateData(
            endpoint: '$tournamentFinishedEndpoint/$tournamentId',
            data: {},
            converter: TournamentChampionDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> getTournamentMatchesStatus(int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
            endpoint: '$getTournamentMatchesStatusEndpoint/$tournamentId',
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> createRoundsConfiguration(ConfigLeagueDTO config) {
    return _apiClient.network
        .updateData(
            endpoint: configLeagueEndpoint,
            data: config.toJson(),
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> inscribeLeagueTeams(
      List<TeamTournament> teams, int tournamentId) {
    final data = jsonEncode(teams);
    return _apiClient.network
        .postData(
            endpoint: '$inscribeLeagueTeamsEndpoint/$tournamentId',
            data: {},
            dataAsString: data,
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<ConfigLeagueInterfaceDTO> getLeagueConfiguration(
      int tournamentId) {
    return _apiClient.network
        .getData(
            endpoint: '$configLeagueEndpoint/$tournamentId',
            converter: ConfigLeagueInterfaceDTO.fromJson)
        .validateResponse();
  }
}
