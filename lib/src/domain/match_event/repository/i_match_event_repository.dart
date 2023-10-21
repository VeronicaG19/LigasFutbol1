import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_res_dto.dart';

import '../dto/referee_match_event/matches_referee_stats.dart';
import '../dto/referee_match_event/referee_global_statics.dart';

abstract class IMatchEventRepository {
  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsReferee(
      int teamMatchId);

  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsRefereeAll(
      int matchId);

  RepositoryResponse<MatchEventResDTO> createMatchEvent(
      MatchEventDTO matchEventDTO);

  RepositoryResponse<RefereeGlobalStatics> getGlobalStatics(
      int refereeId, int leagueId);

  RepositoryResponse<List<MatchesRefereeStats>> getMatchesRefereeStatics(
      int refereeId);
}
