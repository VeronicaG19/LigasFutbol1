part of 'scoring_table_cubit.dart';
enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  playersGeted,
  playersGetting
}
 class ScoringTableState extends Equatable {
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final Tournament tournament;
  final int goalsPending;
  final ScoringTable scoringObj;
  final List<ScroginTableDTO> listScoringTableData;
  final List<TeamTournament> listOfTeams;
  final List<PlayerIntoTeamDTO> palyersList;
  final FormzStatus status;
  final GoalScored goals;
  final bool isAddScoring;

  const ScoringTableState({
      this.isAddScoring = false,
      this.scoringObj = ScoringTable.empty,
      this.goals = const GoalScored.pure(),
      this.palyersList = const [],
      this.listOfTeams = const [],
      this.listScoringTableData = const [],
      this.goalsPending = 0,
      this.tournament = Tournament.empty,
      this.screenStatus= ScreenStatus.initial,
      this.status = FormzStatus.pure,
      this.errorMessage
      });

  @override
  List<Object> get props => [
    screenStatus
    ,listScoringTableData
    ,tournament
    , listOfTeams
    , palyersList
    ,goalsPending
    , scoringObj
    ,isAddScoring
    ,status
    ,goals
    ];

  ScoringTableState copyWith({
    List<TeamTournament>? teamsTournament,
    bool? isAddScoring,
    ScreenStatus? screenStatus,
    List<TeamTournament>? listOfTeams,
    Tournament? tournament,
    int? goalsPending,
    ScoringTable? scoringObj,
    List<ScroginTableDTO>? listScoringTableData,
    List<PlayerIntoTeamDTO>? palyersList,
     String? errorMessage,
     FormzStatus? status,
     GoalScored? goals
  }){
    return ScoringTableState(
      errorMessage: errorMessage ?? this.errorMessage,
      listScoringTableData: listScoringTableData ?? this.listScoringTableData,
      tournament: tournament ?? this.tournament,
      screenStatus: screenStatus ?? this.screenStatus,
      listOfTeams: listOfTeams ?? this.listOfTeams,
      palyersList: palyersList ?? this.palyersList,
      goalsPending: goalsPending ?? this.goalsPending,
      scoringObj: scoringObj ?? this.scoringObj,
      isAddScoring: isAddScoring ?? this.isAddScoring,
      goals: goals ?? this.goals,
      status: status ?? this.status
    );
  }
}


