import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/endpoints.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_global_statics.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/repository/i_match_event_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_res_dto.dart';

import '../dto/referee_match_event/matches_referee_stats.dart';

@LazySingleton(as: IMatchEventRepository)
class MatchEventsRepositoryImpl implements IMatchEventRepository {
  final ApiClient _apiClient;
  MatchEventsRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsReferee(
      int teamMatchId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getMatchEventsRefereeEndpoint/$teamMatchId",
            converter: RefereeMatchEventDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<MatchEventResDTO> createMatchEvent(
      MatchEventDTO matchEventDTO) {
    return _apiClient.network
        .postData(
          endpoint: createMatchEventEndpoint,
          data: matchEventDTO.toJson(),
          converter: MatchEventResDTO.fromJson,
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsRefereeAll(
      int matchId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getMatchEventsRefereeEndpointAll/$matchId",
            converter: RefereeMatchEventDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<RefereeGlobalStatics> getGlobalStatics(
          int refereeId, int leagueId) =>
      _apiClient.fetchData(
          endpoint: '$getRefereeGlobalStaticsEndpoint/$refereeId/$leagueId',
          converter: RefereeGlobalStatics.fromJson);

  @override
  RepositoryResponse<List<MatchesRefereeStats>> getMatchesRefereeStatics(
          int refereeId) =>
      _apiClient.fetchCollectionData(
          endpoint: '$getMatchesRefereeStatsEndpoint/$refereeId',
          converter: MatchesRefereeStats.fromJson);
}
