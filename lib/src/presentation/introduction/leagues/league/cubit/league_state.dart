part of 'league_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class LeagueState extends Equatable {
  final List<Tournament> tournamentList;
  final List<League> leagueList;
  final Tournament tournamentInfo;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const LeagueState({
    this.tournamentList = const [],
    this.leagueList = const [],
    this.tournamentInfo = Tournament.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  LeagueState copyWith({
    List<Tournament>? tournamentList,
    List<League>? leagueList,
    Tournament? tournamentInfo,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return LeagueState(
      tournamentList: tournamentList ?? this.tournamentList,
      leagueList: leagueList ?? this.leagueList,
      tournamentInfo: tournamentInfo ?? this.tournamentInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        tournamentList,
        leagueList,
        tournamentInfo,
        screenStatus,
      ];
}
