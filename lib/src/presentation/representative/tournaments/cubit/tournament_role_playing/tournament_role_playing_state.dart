part of 'tournament_role_playing_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TournamentRolePlayingState extends Equatable {
  final List<MatchesByTournamentsInterface> matchmakingList;
  final ScreenStatus screenStatus;
  final String? errorMessage;

  const TournamentRolePlayingState({
    this.matchmakingList = const [],
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
  });

  TournamentRolePlayingState copyWith({
    List<MatchesByTournamentsInterface>? matchmakingList,
    ScreenStatus? screenStatus,
    String? errorMessage,
  }) {
    return TournamentRolePlayingState(
      matchmakingList: matchmakingList ?? this.matchmakingList,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [matchmakingList, screenStatus];
}
