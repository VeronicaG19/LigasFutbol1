part of 'matches_lists_cubit.dart';

class MatchesListsState extends Equatable {
  final List<MatchesRefereeStats> matches;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const MatchesListsState({
    this.matches = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  MatchesListsState copyWith({
    List<MatchesRefereeStats>? matches,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return MatchesListsState(
      matches: matches ?? this.matches,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [matches, screenState];
}
