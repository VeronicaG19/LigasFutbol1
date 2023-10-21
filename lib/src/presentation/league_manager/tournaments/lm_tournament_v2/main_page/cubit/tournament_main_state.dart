part of 'tournament_main_cubit.dart';

enum CLScreenStatus2 {
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
  loadingDataToFinish,
  dataToFinishLoaded,
}

enum MatchStatus {
  initial,
  loading,
  loaded,
  error,
}

class TournamentMainState extends Equatable {
  final List<Category> categories;
  final List<Tournament> tournaments;
  final List<ResgisterCountInterface> roundNumber;
  final DeatilRolMatchDTO selectedMatch;
  final List<DeatilRolMatchDTO> matches;
  final Category selectedCategory;
  final Tournament selectedTournament;
  final ResgisterCountInterface? selectedRoundNumber;
  final bool roundNumberSorting;
  final LMTournamentScreen screenState;
  final int selectedMenu;
  final String statusTournament;
  final ConfigLeagueInterfaceDTO configLeagueInterfaceDTO;
  final List<TeamTournament>? qualifiedTeamsList;
  final List<TeamTournament> teamsTournament;
  final String rounds;
  final String matchForRound;
  final String numberOrFinals;
  final String tieBreakerType;
  final List<CardTeamOBJ> cardTeamsSlc;
  final ResgisterCountInterface inscribedTeams;
  final int countSelected;
  final int num;
  final String? errorMessage;
  final CLScreenStatus2 screenStatus;
  final String nameCh;
  final TournamentChampionDTO ttDTO;
  final FinalizeMatchDTO finalizeMatchDTO;
  final int matchesWithoutResult;
  final MatchStatus matchStatus;
  final MatchDetailDTO matchDetail;
  final bool canFinish;
  final bool tiebreakerRequired;
  final QualifyingMatchDetailDTO? qualifyingMatchDetail;
  final bool haveConfigShootout;

  const TournamentMainState({
    this.categories = const [],
    this.tournaments = const [],
    this.roundNumber = const [],
    this.matches = const [],
    this.selectedMatch = DeatilRolMatchDTO.empty,
    this.selectedCategory = Category.empty,
    this.selectedTournament = Tournament.empty,
    this.selectedRoundNumber = ResgisterCountInterface.empty,
    this.roundNumberSorting = true,
    this.screenState = LMTournamentScreen.initial,
    this.selectedMenu = 0,
    this.statusTournament = '',
    this.configLeagueInterfaceDTO = ConfigLeagueInterfaceDTO.empty,
    this.qualifiedTeamsList = const [],
    this.teamsTournament = const [],
    this.rounds = '',
    this.matchForRound = '',
    this.numberOrFinals = '',
    this.tieBreakerType = '',
    this.cardTeamsSlc = const [],
    this.inscribedTeams = ResgisterCountInterface.empty,
    this.countSelected = 0,
    this.num = 4,
    this.errorMessage,
    this.screenStatus = CLScreenStatus2.initial,
    this.nameCh = '',
    this.ttDTO = TournamentChampionDTO.empty,
    this.finalizeMatchDTO = FinalizeMatchDTO.empty,
    this.matchesWithoutResult = 0,
    this.matchStatus = MatchStatus.initial,
    this.matchDetail = MatchDetailDTO.empty,
    this.canFinish = false,
    this.tiebreakerRequired = false,
    this.qualifyingMatchDetail = QualifyingMatchDetailDTO.empty,
    this.haveConfigShootout = false,
  });

  TournamentMainState copyWith({
    List<Category>? categories,
    List<Tournament>? tournaments,
    List<ResgisterCountInterface>? roundNumber,
    List<DeatilRolMatchDTO>? matches,
    DeatilRolMatchDTO? selectedMatch,
    Category? selectedCategory,
    Tournament? selectedTournament,
    ResgisterCountInterface? selectedRoundNumber,
    bool? roundNumberSorting,
    LMTournamentScreen? screenState,
    int? selectedMenu,
    String? statusTournament,
    ConfigLeagueInterfaceDTO? configLeagueInterfaceDTO,
    List<TeamTournament>? qualifiedTeamsList,
    List<TeamTournament>? teamsTournament,
    String? rounds,
    String? matchForRound,
    String? numberOrFinals,
    String? tieBreakerType,
    List<CardTeamOBJ>? cardTeamsSlc,
    int? countSelected,
    ResgisterCountInterface? inscribedTeams,
    int? num,
    String? errorMessage,
    CLScreenStatus2? screenStatus,
    String? nameCh,
    TournamentChampionDTO? ttDTO,
    FinalizeMatchDTO? finalizeMatchDTO,
    int? matchesWithoutResult,
    MatchStatus? matchStatus,
    MatchDetailDTO? matchDetail,
    bool? canFinish,
    bool? tiebreakerRequired,
    QualifyingMatchDetailDTO? qualifyingMatchDetail,
    bool? haveConfigShootout,
  }) {
    return TournamentMainState(
      categories: categories ?? this.categories,
      tournaments: tournaments ?? this.tournaments,
      roundNumber: roundNumber ?? this.roundNumber,
      matches: matches ?? this.matches,
      selectedMatch: selectedMatch ?? this.selectedMatch,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTournament: selectedTournament ?? this.selectedTournament,
      selectedRoundNumber: selectedRoundNumber ?? this.selectedRoundNumber,
      roundNumberSorting: roundNumberSorting ?? this.roundNumberSorting,
      screenState: screenState ?? this.screenState,
      selectedMenu: selectedMenu ?? this.selectedMenu,
      statusTournament: statusTournament ?? this.statusTournament,
      configLeagueInterfaceDTO:
          configLeagueInterfaceDTO ?? this.configLeagueInterfaceDTO,
      qualifiedTeamsList: qualifiedTeamsList ?? this.qualifiedTeamsList,
      teamsTournament: teamsTournament ?? this.teamsTournament,
      rounds: rounds ?? this.rounds,
      matchForRound: matchForRound ?? this.matchForRound,
      numberOrFinals: numberOrFinals ?? this.numberOrFinals,
      tieBreakerType: tieBreakerType ?? this.tieBreakerType,
      cardTeamsSlc: cardTeamsSlc ?? this.cardTeamsSlc,
      countSelected: countSelected ?? this.countSelected,
      inscribedTeams: inscribedTeams ?? this.inscribedTeams,
      num: num ?? this.num,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      nameCh: nameCh ?? this.nameCh,
      ttDTO: ttDTO ?? this.ttDTO,
      finalizeMatchDTO: finalizeMatchDTO ?? this.finalizeMatchDTO,
      matchesWithoutResult: matchesWithoutResult ?? this.matchesWithoutResult,
      matchStatus: matchStatus ?? this.matchStatus,
      matchDetail: matchDetail ?? this.matchDetail,
      canFinish: canFinish ?? this.canFinish,
      tiebreakerRequired: tiebreakerRequired ?? this.tiebreakerRequired,
      qualifyingMatchDetail:
          qualifyingMatchDetail ?? this.qualifyingMatchDetail,
      haveConfigShootout: haveConfigShootout ?? this.haveConfigShootout,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        tournaments,
        roundNumber,
        matches,
        selectedMatch,
        selectedCategory,
        selectedTournament,
        selectedRoundNumber,
        roundNumberSorting,
        screenState,
        selectedMenu,
        statusTournament,
        configLeagueInterfaceDTO,
        qualifiedTeamsList,
        teamsTournament,
        rounds,
        rounds,
        matchForRound,
        numberOrFinals,
        tieBreakerType,
        cardTeamsSlc,
        countSelected,
        inscribedTeams,
        num,
        errorMessage,
        screenStatus,
        nameCh,
        ttDTO,
        finalizeMatchDTO,
        matchesWithoutResult,
        matchStatus,
        matchDetail,
        canFinish,
        tiebreakerRequired,
        qualifyingMatchDetail,
        haveConfigShootout,
      ];
}
