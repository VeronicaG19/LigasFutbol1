import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/countResponse/entity/register_count_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_eliminatory_dto/qualifying_match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/edit_match_dto/edit_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/end_match/end_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/finalize_match_dto/finalize_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_role_dto/match_role_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/matches_by_player/matches_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/start_match/start_match_res_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/entity/match.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../dto/match_team_matches_refree.dart/MatchTeamMatchesRefereeDTO.dart';
import '../interface/matches_by_tournament_interface.dart';
import 'i_matches_repository.dart';

@LazySingleton(as: IMatchesRepository)
class CategoryRepositoryImpl implements IMatchesRepository {
  final ApiClient _apiClient;

  CategoryRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getMatchesByTournament(int tournamenId, {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            converter: MatchesByTournamentsInterface.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint: "$getMatchesByTournamentEndpoint/$tournamenId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<MatchesByPlayerDTO>> getMatchesByPlayer(
      int personId, int teamId) {
    return _apiClient.network
        .getCollectionData(
            converter: MatchesByPlayerDTO.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint:
                "${getMatchesByPlayerEndpoint}?partyId=$personId&teamId=$teamId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<DetailMatchDTO>> getDetailMatchByPlayer(int matchId) {
    return _apiClient.network
        .getCollectionData(
            converter: DetailMatchDTO.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint: "${getDetailMatchByPlayerEndpoint}?matchId=$matchId")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getListMatchesByTournament(int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getMatchesByTournamentEndpoint$tournamentId",
            converter: MatchesByTournamentsInterface.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResultDTO> createRolesGamesByTournamentId(
      int tournamentId) {
    return _apiClient.network
        .postData(
            data: null,
            endpoint: '$createRoleGameAutoPresident$tournamentId',
            converter: ResultDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeMatchDTO>> getRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (date != null) {
      data.addAll({'matchDate': date});
    }
    if (refereeId != null) {
      data.addAll({'refereeId': refereeId});
    }
    if (tournamentId != null) {
      data.addAll({'tournamentId': tournamentId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getRefereeMatchesEndpoint,
            queryParams: data,
            converter: RefereeMatchDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<DeatilRolMatchDTO>> getMatchDetailByTorunamentId(
      int tournamentId, int? roundNumber) {
    return (roundNumber != null)
        ? _apiClient.network
            .getCollectionData(
                endpoint: '$getMatchDetailByTorunament$tournamentId',
                queryParams: {'roundNumber': roundNumber},
                converter: DeatilRolMatchDTO.fromJson)
            .validateResponse()
        : _apiClient.network
            .getCollectionData(
                endpoint: '$getMatchDetailByTorunament$tournamentId',
                converter: DeatilRolMatchDTO.fromJson)
            .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeMatchDTO>> getHistoricRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (date != null) {
      data.addAll({'matchDate': date});
    }
    if (refereeId != null) {
      data.addAll({'refereeId': refereeId});
    }
    if (tournamentId != null) {
      data.addAll({'tournamentId': tournamentId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getHistoricRefereeMatchesEndpoint,
            queryParams: data,
            converter: RefereeMatchDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeMatchDTO>> getCalendarRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (date != null) {
      data.addAll({'matchDate': date});
    }
    if (refereeId != null) {
      data.addAll({'refereeId': refereeId});
    }
    if (tournamentId != null) {
      data.addAll({'tournamentId': tournamentId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getCalendaraRefereeMatchesEndpoint,
            queryParams: data,
            converter: RefereeMatchDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<ResgisterCountInterface>> getRoundNumberAnpending(
      int tournamentId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getMatchPendingByRoundNumber$tournamentId',
            converter: ResgisterCountInterface.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<FinalizeMatchDTO> finalizeMatch(
      FinalizeMatchDTO finalizeMatchDTO) {
    return _apiClient.network
        .updateData(
            endpoint: getFinalizeMatchPresident,
            data: finalizeMatchDTO.toJson(),
            converter: FinalizeMatchDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<EditMatchDTO> editMatchDto(EditMatchDTO editMatchDTO) {
    return _apiClient.network
        .updateData(
            endpoint: getUpdateMatcDTOPresident,
            data: editMatchDTO.toJson(),
            converter: EditMatchDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchSpr> deleteMatch(int matchId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$getDeleteMatch$matchId', converter: MatchSpr.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getNextRound(int tournamentId) {
    return _apiClient.network
        .getData(
            endpoint: '$getNextRoundNumber$tournamentId',
            converter: ResgisterCountInterface.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchRoleDTO> createRolesMatchs(
      List<MatchRoleDTO> listMatchRoleDTO) {
    final data = jsonEncode(listMatchRoleDTO);
    return _apiClient.network
        .postData(
            endpoint: getCreateEditRols,
            data: {},
            dataAsString: data,
            converter: MatchRoleDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchTeamMatchesRefereeDTO> createRolesClass(
      List<MatchTeamMatchesRefereeDTO> listMatchRoleDTO, int tournamentId) {
    final data = jsonEncode(listMatchRoleDTO);
    return _apiClient.network
        .postData(
            endpoint: '$getCreateRolsC/$tournamentId',
            data: {},
            dataAsString: data,
            converter: MatchTeamMatchesRefereeDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchDetailDTO> getMatchDetail(int matchId) {
    return _apiClient.network
        .getData(
            endpoint: "$getRefereeMatchDetailsEndpoint$matchId",
            converter: MatchDetailDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<StartMatchResDTO> startMatch(int matchId) {
    return _apiClient.network
        .updateData(
            endpoint: "$startMatchEndpoint$matchId",
            data: {},
            converter: StartMatchResDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResultDTO> endMatch(EndMatchDTO endMatch) {
    return _apiClient.network
        .updateData(
            endpoint: "$endMatchEndpoint",
            data: endMatch.toJson(),
            converter: ResultDTO.fromJson)
        .validateResponse();
  }
  /*

  @override
  RepositoryResponse<StartMatchResDTO> crtMatchEvent(MatchEventDTO matchId) {
    return _apiClient.network
        .postData(
            endpoint: "$crtMatchEventEndpoint",
            data: {},
            converter: StartMatchResDTO.fromJson)
        .validateResponse();
  }
  */

  @override
  RepositoryResponse<String> updateMatchDate(
      DateTime day, DateTime hour, int matchId) {
    return _apiClient.network
        .updateData(
            endpoint: updateMatchDateEndpoint,
            data: {
              'dateMatch': DateFormat('yyyy-MM-ddTHH:mm:ss').format(day),
              'fieldId': 0,
              'refereeId': 0,
              'hourMatch': DateFormat('yyyy-MM-ddTHH:mm:ss').format(hour),
              'matchId': matchId
            },
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateMatchField(int matchId, int fieldId) {
    return _apiClient.network
        .updateData(
            endpoint: '$updateMatchFieldEndpoint/$matchId/$fieldId',
            data: {},
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateMatchReferee(int matchId, int refereeId) {
    return _apiClient.network
        .updateData(
            endpoint: '$updateMatchRefereeEndpoint/$matchId/$refereeId',
            data: {},
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<QualifyingMatchDetailDTO> getDetailEliminatory(
      int matchId) {
    return _apiClient.network
        .getData(
            endpoint: "$getDetailEliminatoryEndpoint/$matchId",
            converter: QualifyingMatchDetailDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchSpr> getMatchDetailByEventId(int eventId) {
    // TODO: implement getMatchDetailByEventId
    return _apiClient.network
        .getData(
            endpoint: "$getMatchByEventId/$eventId",
            converter: MatchSpr.fromJson)
        .validateResponse();
    //    //getMatchByEventId
  }
}
