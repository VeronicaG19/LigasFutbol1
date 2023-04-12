part of 'team_matches_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TeamMatchesState extends Equatable {
  final List<MatchesByTeamDTO> matchesList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TeamMatchesState({
    this.matchesList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TeamMatchesState copyWith({
    List<MatchesByTeamDTO>? matchesList,
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TeamMatchesState(
      matchesList: matchesList ?? this.matchesList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [matchesList, screenStatus];
}
