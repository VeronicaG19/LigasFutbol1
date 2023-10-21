import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import '../../../../../domain/match_event/dto/referee_match_event/matches_referee_stats.dart';
import '../../../../../domain/match_event/service/i_match_event_service.dart';

part 'matches_lists_state.dart';

@injectable
class MatchesListsCubit extends Cubit<MatchesListsState> {
  MatchesListsCubit(this._matchService) : super(const MatchesListsState());

  final IMatchEventService _matchService;
  late final int _refereeId;
  late final int _leagueId;
  late final RefereeEventType _eventType;

  Future<void> onLoadInitialData(final int? refereeId, final int? leagueId,
      final RefereeEventType? eventType) async {
    _refereeId = refereeId ?? 0;
    _leagueId = leagueId ?? 0;
    _eventType = eventType ?? RefereeEventType.all;
    onLoadMatchesList();
  }

  Future<void> onLoadMatchesList() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final matches = await _matchService.getMatchesRefereeStatics(
        _refereeId, _leagueId, _eventType);
    emit(state.copyWith(
        matches: matches, screenState: BasicCubitScreenState.loaded));
  }
}
