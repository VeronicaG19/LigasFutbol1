part of 'tournament_general_table_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TournamentGeneralTableState extends Equatable {
  final List<ScoringTournamentDTO> generalTable;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TournamentGeneralTableState({
    this.generalTable = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TournamentGeneralTableState copyWith({
    List<ScoringTournamentDTO>? generalTable,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TournamentGeneralTableState(
      generalTable: generalTable ?? this.generalTable,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [generalTable, screenStatus];
}
