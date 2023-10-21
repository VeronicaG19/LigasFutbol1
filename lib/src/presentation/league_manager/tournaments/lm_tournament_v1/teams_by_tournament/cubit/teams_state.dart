part of 'teams_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  teamsGetting,
  teamsGetted,
  success
}

class TeamsLMState extends Equatable {
  final Tournament tournament;
  final List<Team> teams;
  final ResgisterCountInterface inscribedTeams;
  final List<TeamTournament> teamsTournament;
  final List<TeamTournamentDto> teamsTournamentDto;
  final List<CardTeamOBJ> cardTeamsSlc;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final int countSelected;

  const TeamsLMState(
      {this.countSelected = 0,
      this.teams = const [],
      this.tournament = Tournament.empty,
      this.teamsTournament = const [],
      this.teamsTournamentDto = const [],
      this.screenStatus = ScreenStatus.initial,
      this.cardTeamsSlc = const [],
      this.inscribedTeams = ResgisterCountInterface.empty,
      this.errorMessage});

  @override
  List<Object> get props => [
        teams,
        screenStatus,
        tournament,
        teamsTournament,
        teamsTournamentDto,
        cardTeamsSlc,
        countSelected,
        inscribedTeams
      ];

  TeamsLMState copyWith(
      {List<Team>? teams,
      Tournament? tournament,
      List<TeamTournament>? teamsTournament,
      List<TeamTournamentDto>? teamsTournamentDto,
      ScreenStatus? screenStatus,
      List<CardTeamOBJ>? cardTeamsSlc,
      String? errorMessage,
      int? countSelected,
      ResgisterCountInterface? inscribedTeams}) {
    return TeamsLMState(
        teams: teams ?? this.teams,
        teamsTournament: teamsTournament ?? this.teamsTournament,
        teamsTournamentDto: teamsTournamentDto ?? this.teamsTournamentDto,
        errorMessage: errorMessage ?? this.errorMessage,
        screenStatus: screenStatus ?? this.screenStatus,
        tournament: tournament ?? this.tournament,
        cardTeamsSlc: cardTeamsSlc ?? this.cardTeamsSlc,
        countSelected: countSelected ?? this.countSelected,
        inscribedTeams: inscribedTeams ?? this.inscribedTeams);
  }
}
