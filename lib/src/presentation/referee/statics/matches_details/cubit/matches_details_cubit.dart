import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';
import '../../../../../domain/match_event/service/i_match_event_service.dart';

part 'matches_details_state.dart';

@injectable
class MatchesDetailsCubit extends Cubit<MatchesDetailsState> {
  MatchesDetailsCubit(this._matchEventService)
      : super(const MatchesDetailsState());

  final IMatchEventService _matchEventService;
  late final int _matchId;

  Future<void> onLoadInitialData(final int? matchId) async {
    _matchId = matchId ?? 0;
    onLoadMatchDetail();
  }

  Future<void> onLoadMatchDetail() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
        await _matchEventService.getMatchEventsRefereeAll(_matchId);
    final matches = response.getOrElse(() => []);
    emit(state.copyWith(
        matchDetail: matches, screenState: BasicCubitScreenState.loaded));
  }
}
