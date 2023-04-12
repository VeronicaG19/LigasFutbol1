part of 'request_team_by_league_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class RequestTeamByLeagueState extends Equatable {
  final List<Team> teamList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RequestTeamByLeagueState({
    this.teamList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RequestTeamByLeagueState copyWith({
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RequestTeamByLeagueState(
      teamList: teamList ?? this.teamList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [teamList, screenStatus];
}
