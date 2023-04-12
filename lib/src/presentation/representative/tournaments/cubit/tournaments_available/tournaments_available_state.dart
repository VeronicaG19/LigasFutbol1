part of 'tournaments_available_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  loadingAvailableTournaments,
  availableTournamentsLoaded,
  sendingRequest,
  requestSend,
  sendError,
}

class TournamentsAvailableState extends Equatable {
  final List<League> leaguesList;
  final int? indexLeagueSelec;
  final List<GetOpenTournamentsInterface> tournamentsList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TournamentsAvailableState({
    this.leaguesList = const [],
    this.indexLeagueSelec = 0,
    this.tournamentsList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TournamentsAvailableState copyWith({
    List<League>? leaguesList,
    int? indexLeagueSelec,
    List<GetOpenTournamentsInterface>? tournamentsList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TournamentsAvailableState(
      leaguesList: leaguesList ?? this.leaguesList,
      indexLeagueSelec: indexLeagueSelec ?? this.indexLeagueSelec,
      tournamentsList: tournamentsList ?? this.tournamentsList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props =>
      [leaguesList, indexLeagueSelec, tournamentsList, screenStatus];
}
