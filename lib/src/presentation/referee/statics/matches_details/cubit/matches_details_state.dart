part of 'matches_details_cubit.dart';

class MatchesDetailsState extends Equatable {
  final List<RefereeMatchEventDTO> matchDetail;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const MatchesDetailsState({
    this.matchDetail = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  MatchesDetailsState copyWith({
    List<RefereeMatchEventDTO>? matchDetail,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return MatchesDetailsState(
      matchDetail: matchDetail ?? this.matchDetail,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [matchDetail, screenState];
}
