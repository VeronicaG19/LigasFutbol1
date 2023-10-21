part of 'rating_detail_bloc.dart';

@freezed
class RatingDetailEvent with _$RatingDetailEvent {
  const factory RatingDetailEvent.started(int matchId, String type) = _Started;
}
