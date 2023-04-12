part of 'matches_by_tournament_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class MatchesByTournamentState extends Equatable {
  final List<MatchesByTournamentsInterface> matchesList;
  final Field fieldData;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final String statusTournament;
  final String nameCh;

  const MatchesByTournamentState({
    this.matchesList = const [],
    this.fieldData = Field.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.statusTournament ='',
    this.nameCh =''
  });

  MatchesByTournamentState copyWith({
    List<MatchesByTournamentsInterface>? matchesList,
    String? errorMessage,
    Field? fieldData,
    ScreenStatus? screenStatus,
    String? statusTournament,
    String? nameCh
  }) {
    return MatchesByTournamentState(
      fieldData: fieldData ?? this.fieldData,
      matchesList: matchesList ?? this.matchesList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      statusTournament: statusTournament ?? this.statusTournament,
      nameCh: nameCh ?? this.nameCh,
    );
  }

  @override
  List<Object> get props => [matchesList, screenStatus, fieldData,statusTournament,
    nameCh];
}
