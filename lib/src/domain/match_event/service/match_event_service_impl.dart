import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_global_statics.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/repository/i_match_event_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/service/i_match_event_service.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_res_dto.dart';

import '../../../core/enums.dart';
import '../dto/referee_match_event/matches_referee_stats.dart';

@LazySingleton(as: IMatchEventService)
class MatchEventServiceImpl implements IMatchEventService {
  final IMatchEventRepository _matchEventRepository;
  MatchEventServiceImpl(this._matchEventRepository);

  @override
  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsReferee(
      int teamMatchId) {
    return _matchEventRepository.getMatchEventsReferee(teamMatchId);
  }

  @override
  RepositoryResponse<MatchEventResDTO> createMatchEvent(
      MatchEventDTO matchEventDTO) {
    return _matchEventRepository.createMatchEvent(matchEventDTO);
  }

  @override
  RepositoryResponse<List<RefereeMatchEventDTO>> getMatchEventsRefereeAll(
      int matchId) {
    return _matchEventRepository.getMatchEventsRefereeAll(matchId);
  }

  @override
  RepositoryResponse<RefereeGlobalStatics> getGlobalStatics(
          int refereeId, int leagueId) =>
      _matchEventRepository.getGlobalStatics(refereeId, leagueId);

  @override
  Future<List<MatchesRefereeStats>> getMatchesRefereeStatics(
          int refereeId, int leagueId, RefereeEventType eventType) =>
      _matchEventRepository.getMatchesRefereeStatics(refereeId).then((value) =>
          value.fold((l) => [],
              (r) => _filterMatchesByLeague(r, leagueId, eventType)));

  List<MatchesRefereeStats> _filterMatchesByLeague(
          List<MatchesRefereeStats> matches,
          int leagueId,
          RefereeEventType eventType) =>
      matches.where((element) {
        try {
          if (RefereeEventType.yellowCard == eventType) {
            return element.leagueId == leagueId &&
                int.parse(element.tarjetaAmarillas) > 0;
          } else if (RefereeEventType.redCard == eventType) {
            return element.leagueId == leagueId &&
                int.parse(element.tarjetasRojas) > 0;
          } else {
            return element.leagueId == leagueId;
          }
        } catch (e) {
          return element.leagueId == leagueId;
        }
      }).toList();
}
