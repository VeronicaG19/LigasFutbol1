part of 'goals_by_tournament_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class GoalsByTournamentState extends Equatable {
  final List<GoalsTournamentDTO> goalsTournament;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const GoalsByTournamentState({
    this.goalsTournament = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  GoalsByTournamentState copyWith({
    List<GoalsTournamentDTO>? goalsTournament,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return GoalsByTournamentState(
      goalsTournament: goalsTournament ?? this.goalsTournament,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [goalsTournament, screenStatus];
}
