part of 'classification_by_tournament_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class ClassificationByTournamentState extends Equatable {
  final List<ScoringTournamentDTO> scoringTournament;
  final ScoringSystem scoringSystem;
  final bool isShootout;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const ClassificationByTournamentState({
    this.scoringTournament = const [],
    this.scoringSystem = ScoringSystem.empty,
    this.isShootout = false,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  ClassificationByTournamentState copyWith({
    List<ScoringTournamentDTO>? scoringTournament,
    String? errorMessage,
    bool? isShootout,
    ScoringSystem? scoringSystem,
    ScreenStatus? screenStatus,
  }) {
    return ClassificationByTournamentState(
      scoringTournament: scoringTournament ?? this.scoringTournament,
      errorMessage: errorMessage ?? this.errorMessage,
      isShootout: isShootout ?? this.isShootout,
      scoringSystem: scoringSystem ?? this.scoringSystem,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props =>
      [scoringTournament, screenStatus, scoringSystem, isShootout];
}
