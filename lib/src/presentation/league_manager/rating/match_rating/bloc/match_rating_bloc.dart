import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/qualification/dto/rating_topics/rating_topics_dto.dart';
import '../../../../../domain/qualification/service/i_qualification_service.dart';

part 'match_rating_bloc.freezed.dart';
part 'match_rating_event.dart';
part 'match_rating_state.dart';

@injectable
class MatchRatingBloc extends Bloc<MatchRatingEvent, MatchRatingState> {
  final IQualificationService _service;
  MatchRatingBloc(this._service) : super(const MatchRatingState.initial()) {
    on<MatchRatingEvent>((event, emit) async {
      await event.map(
          started: (value) async => await _onStart(value, emit),
          loadRatings: (value) async => await _onLoadRatings(value, emit));
    });
  }

  Future<void> _onStart(_Started event, Emitter<MatchRatingState> emit) async {
    emit(const MatchRatingState.loading());
    final response = await _service.getRatingTopics(event.matchId);
    response.fold((l) => emit(MatchRatingState.error(l.errorMessage)),
        (r) => emit(MatchRatingState.ratingsLoaded(r)));
  }

  Future<void> _onLoadRatings(
      _LoadRatings event, Emitter<MatchRatingState> emit) async {
    emit(const MatchRatingState.loading());
    final response = await _service.getRatingTopics(event.matchId);
    response.fold((l) => emit(MatchRatingState.error(l.errorMessage)),
        (r) => emit(MatchRatingState.ratingsLoaded(r)));
  }
}
