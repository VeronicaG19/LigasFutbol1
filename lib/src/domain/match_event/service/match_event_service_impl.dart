import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/repository/i_match_event_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/service/i_match_event_service.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_res_dto.dart';

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
}
