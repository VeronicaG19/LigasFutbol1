part of 'performance_player_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class PerformancePlayerState extends Equatable {
  final List<TournamentByPlayer> tournamentList;
  final List<PerformanceByTournament> staticsList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const PerformancePlayerState({
    this.tournamentList = const [],
    this.staticsList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  PerformancePlayerState copyWith({
    List<TournamentByPlayer>? tournamentList,
    List<PerformanceByTournament>? staticsList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return PerformancePlayerState(
      tournamentList: tournamentList ?? this.tournamentList,
      staticsList: staticsList ?? this.staticsList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [tournamentList, staticsList, screenStatus];
}
