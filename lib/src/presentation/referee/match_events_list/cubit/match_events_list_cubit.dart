import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/service/i_match_event_service.dart';
import '../../../../domain/match_event/dto/referee_match_event/referee_match_event_dto.dart';

part 'match_events_list_state.dart';

@injectable
class MatchEventsListCubit extends Cubit<MatchEventsListState> {
  MatchEventsListCubit(this._matchEventService)
      : super(const MatchEventsListState());

  final IMatchEventService _matchEventService;

  Future<void> loadEventsReferee({required int teamMatchId}) async{
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _matchEventService.getMatchEventsReferee(teamMatchId);

    response.fold(
            (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage
        )),(r)
    {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded,
          eventsList: r
      ));
    });
  }

  Future<void> loadAllEventsReferee({required int matchId}) async{
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _matchEventService.getMatchEventsRefereeAll(matchId);

    response.fold(
            (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage
        )),(r)
    {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded,
          eventsList: r
      ));
    });
  }
}
