part of 'rating_detail_bloc.dart';

@freezed
class RatingDetailState with _$RatingDetailState {
  const factory RatingDetailState.initial() = _Initial;
  const factory RatingDetailState.loading() = _Loading;
  const factory RatingDetailState.error(String errorMessage) = _Error;
  const factory RatingDetailState.ratingsLoaded(List<Qualification> ratings) =
      _RatingsLoaded;
}
