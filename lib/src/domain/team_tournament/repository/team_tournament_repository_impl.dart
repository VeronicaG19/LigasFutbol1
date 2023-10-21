import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/countResponse/entity/register_count_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/dto/team_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/repository/i_team_tournament_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';

@LazySingleton(as: ITeamTournamentRepository)
class TeamTournamentImpl implements ITeamTournamentRepository {
  final ApiClient _apiClient;

  TeamTournamentImpl(this._apiClient);

  @override
  RepositoryResponse<List<TeamTournament>> getTeamTournamentByTournament(
      int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTeamTournamentsByTournamentId$tournamentId',
            converter: TeamTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<TeamTournamentDto>> getTournamentTeamDataBytournament(
      int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getTournamentTeamDataBytournamentId$tournamentId',
            converter: TeamTournamentDto.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<TeamTournament> inscribeTeamOnATournament(
      List<TeamTournament> teamTournament) {
    final data = jsonEncode(teamTournament);
    return _apiClient.network
        .postData(
            endpoint: registerTeamOnTournamet,
            data: {},
            dataAsString: data,
            converter: TeamTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getTeamcounTorunament(
      int tournamentId) {
    return _apiClient.network
        .getData(
            endpoint: '$getCountTeamOnTournametRegister$tournamentId',
            converter: ResgisterCountInterface.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<TeamTournament> unsubscribeTeamTournament(
      int teamTournamentId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$getUnsubscribeTeamsTournament$teamTournamentId',
            converter: TeamTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<ScoringTournamentDTO>> getGeneralTableByTournament(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            endpoint: '$getGeneralTableByTournamentId$tournamentId',
            converter: ScoringTournamentDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<TeamTournament>> getQualifiedTeams(int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getQualifiedTeamsEndpoint/$tournamentId',
            converter: TeamTournament.fromJson)
        .validateResponse();
  }
}
//
