part of 'match_rating_bloc.dart';

@freezed
class MatchRatingEvent with _$MatchRatingEvent {
  const factory MatchRatingEvent.started(int matchId) = _Started;
  const factory MatchRatingEvent.loadRatings(int matchId) = _LoadRatings;
}
