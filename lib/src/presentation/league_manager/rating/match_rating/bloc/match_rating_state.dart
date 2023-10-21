part of 'match_rating_bloc.dart';

@freezed
class MatchRatingState with _$MatchRatingState {
  const factory MatchRatingState.initial() = _Initial;
  const factory MatchRatingState.loading() = _Loading;
  const factory MatchRatingState.error(String errorMessage) = _Error;
  const factory MatchRatingState.ratingsLoaded(List<RatingTopicsDTO> topics) =
      _RatingsLoaded;
}
