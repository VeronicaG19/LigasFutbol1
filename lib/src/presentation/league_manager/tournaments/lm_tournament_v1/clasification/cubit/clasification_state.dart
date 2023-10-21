part of 'clasification_cubit.dart';

enum CLScreenStatus {
  initial,
  loading,
  loaded,
  error,
  creatingRoleGame,
  createdRoleGame,
  refereetListLoaded,
  refereetListLing,
  fieldtListLoaded,
  fieldtListLoading,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  matchFinalized,
  createdConfiguration,
  teamsGetted,
  createInscribeLeague,
}

class ClasificationState extends Equatable {
  final Tournament tournament;
  final ScoringSystem scoringSystem;
  final String? errorMessage;
  final ScoringSystem scoringSystem2;
  final CLScreenStatus screenStatus;
  final bool shootout;
  final List<ScoringTournamentDTO> scoringTournament;
  final List<DeatilRolMatchDTO> dailMaitch;
  final List<ResgisterCountInterface> roundList;
  final FinalizeMatchDTO finalizeMatchDTO;
  final List<RefereeByLeagueDTO> refereetList;
  final List<Field> fieldtList;
  final List<Field> rentalFields;
  final List<RefereeByLeagueDTO> availabilityReferee;
  final Field selectedRentalField;
  final RefereeByLeagueDTO selectedReferee;
  final EditMatchDTO editMatchObj;
  final TournamentChampionDTO ttDTO;
  final String statusTournament;
  final String nameCh;
  final String rounds;
  final String matchForRound;
  final String numberOrFinals;
  final String tieBreakerType;
  final List<TeamTournament> teamsTournament;
  final List<CardTeamOBJ> cardTeamsSlc;
  final ResgisterCountInterface inscribedTeams;
  final int countSelected;
  final int num;

  const ClasificationState({
    this.tournament = Tournament.empty,
    this.scoringSystem2 = ScoringSystem.empty,
    this.shootout = false,
    this.roundList = const [],
    this.scoringTournament = const [],
    this.scoringSystem = ScoringSystem.empty,
    this.screenStatus = CLScreenStatus.initial,
    this.dailMaitch = const [],
    this.errorMessage,
    this.finalizeMatchDTO = FinalizeMatchDTO.empty,
    this.refereetList = const [],
    this.fieldtList = const [],
    this.rentalFields = const [],
    this.availabilityReferee = const [],
    this.selectedRentalField = Field.empty,
    this.selectedReferee = RefereeByLeagueDTO.empty,
    this.editMatchObj = EditMatchDTO.empty,
    this.ttDTO = TournamentChampionDTO.empty,
    this.statusTournament = '',
    this.nameCh = '',
    this.rounds = '',
    this.matchForRound = '',
    this.numberOrFinals = '',
    this.tieBreakerType = '',
    this.teamsTournament = const [],
    this.cardTeamsSlc = const [],
    this.inscribedTeams = ResgisterCountInterface.empty,
    this.countSelected = 0,
    this.num = 4,
  });

  @override
  List<Object> get props => [
        scoringSystem,
        screenStatus,
        tournament,
        shootout,
        scoringSystem2,
        scoringTournament,
        dailMaitch,
        roundList,
        finalizeMatchDTO,
        refereetList,
        fieldtList,
        selectedRentalField,
        selectedReferee,
        rentalFields,
        availabilityReferee,
        editMatchObj,
        ttDTO,
        statusTournament,
        nameCh,
        rounds,
        matchForRound,
        numberOrFinals,
        tieBreakerType,
        teamsTournament,
        cardTeamsSlc,
        countSelected,
        inscribedTeams,
        num,
      ];

  ClasificationState copyWith({
    ScoringSystem? scoringSystem,
    ScoringSystem? scoringSystem2,
    List<ScoringTournamentDTO>? scoringTournament,
    List<DeatilRolMatchDTO>? dailMaitch,
    List<ResgisterCountInterface>? roundList,
    CLScreenStatus? screenStatus,
    FinalizeMatchDTO? finalizeMatchDTO,
    Tournament? tournament,
    bool? shootout,
    String? errorMessage,
    Field? selectedRentalField,
    RefereeByLeagueDTO? selectedReferee,
    List<RefereeByLeagueDTO>? refereetList,
    List<Field>? fieldtList,
    List<Field>? rentalFields,
    List<RefereeByLeagueDTO>? availabilityReferee,
    EditMatchDTO? editMatchObj,
    TournamentChampionDTO? ttDTO,
    String? statusTournament,
    String? nameCh,
    String? rounds,
    String? matchForRound,
    String? numberOrFinals,
    String? tieBreakerType,
    List<TeamTournament>? teamsTournament,
    List<CardTeamOBJ>? cardTeamsSlc,
    int? countSelected,
    ResgisterCountInterface? inscribedTeams,
    int? num,
  }) {
    return ClasificationState(
      scoringSystem: scoringSystem ?? this.scoringSystem,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      shootout: shootout ?? this.shootout,
      tournament: tournament ?? this.tournament,
      scoringTournament: scoringTournament ?? this.scoringTournament,
      scoringSystem2: scoringSystem2 ?? this.scoringSystem2,
      dailMaitch: dailMaitch ?? this.dailMaitch,
      roundList: roundList ?? this.roundList,
      finalizeMatchDTO: finalizeMatchDTO ?? this.finalizeMatchDTO,
      refereetList: refereetList ?? this.refereetList,
      fieldtList: fieldtList ?? this.fieldtList,
      rentalFields: rentalFields ?? this.rentalFields,
      availabilityReferee: availabilityReferee ?? this.availabilityReferee,
      selectedRentalField: selectedRentalField ?? this.selectedRentalField,
      selectedReferee: selectedReferee ?? this.selectedReferee,
      editMatchObj: editMatchObj ?? this.editMatchObj,
      ttDTO: ttDTO ?? this.ttDTO,
      statusTournament: statusTournament ?? this.statusTournament,
      nameCh: nameCh ?? this.nameCh,
      rounds: rounds ?? this.rounds,
      matchForRound: matchForRound ?? this.matchForRound,
      numberOrFinals: numberOrFinals ?? this.numberOrFinals,
      tieBreakerType: tieBreakerType ?? this.tieBreakerType,
      teamsTournament: teamsTournament ?? this.teamsTournament,
      cardTeamsSlc: cardTeamsSlc ?? this.cardTeamsSlc,
      countSelected: countSelected ?? this.countSelected,
      inscribedTeams: inscribedTeams ?? this.inscribedTeams,
      num: num ?? this.num,
    );
  }
}
