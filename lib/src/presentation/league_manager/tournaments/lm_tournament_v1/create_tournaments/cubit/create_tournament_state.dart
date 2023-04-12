part of 'create_tournament_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class CreateTournamentState extends Equatable {
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final FormzStatus formzStatus;
  final List<LookUpValue> lookUpValues;
  final Tournament createTournament;
  final LookUpValue typeTournament;
  final TournamentName tournamentName;
  final InscriptionDate inscriptionDate;
  final MaxTeams maxTeams;
  final MaxPlayer maxPlayer;
  final TemporaryReprimands temporaryReprimands;
  final List<LookUpValue> typeFotbolValues;
  final LookUpValue typeFotbol;
  final GamesTimes gamesTimes;
  final DurationByTime durationByTime;
  final BreakNumbers breakNumbers;
  final BreakDuration breakDuration;
  final YellowCardFine yellowCardFine;
  final RedCardFine redCardFine;
  final GamesChanges gamesChanges;
  final PointPerLoss pointPerLoss;
  final PointPerTie pointPerTie;
  final PointPerWin pointPerWin;
  final PointsPerLossShootOut pointsPerLossShootOut;
  final PointsPerWinShootOut pointsPerWinShootOut;
  final League league;
  final Category category;
  final bool shooutOutFlag;
  final bool cardsflag;
  final List<Category> categoriesList;
  final List<CategorySelect> categorySelect;
  final bool flagCategorySelect;
  final String timeMatchD;
  final bool allFormIsValid;

  const CreateTournamentState( {
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.formzStatus = FormzStatus.pure,
    this.lookUpValues = const [],
    this.createTournament = Tournament.empty,
    this.typeTournament = LookUpValue.empty,
    this.tournamentName = const TournamentName.pure(),
    this.inscriptionDate = const InscriptionDate.pure(),
    this.maxTeams = const MaxTeams.pure(),
    this.maxPlayer = const MaxPlayer.pure(),
    this.temporaryReprimands = const TemporaryReprimands.pure(),
    this.typeFotbolValues = const [],
    this.typeFotbol = LookUpValue.empty,
    this.gamesTimes = const GamesTimes.pure(),
    this.durationByTime = const DurationByTime.pure(),
    this.breakNumbers = const BreakNumbers.pure(),
    this.breakDuration = const BreakDuration.pure(),
    this.yellowCardFine = const YellowCardFine.pure(),
    this.redCardFine = const RedCardFine.pure(),
    this.gamesChanges = const GamesChanges.pure(),
    this.pointPerLoss = const PointPerLoss.pure(),
    this.pointPerTie = const PointPerTie.pure(),
    this.pointPerWin = const PointPerWin.pure(),
    this.pointsPerLossShootOut = const PointsPerLossShootOut.pure(),
    this.pointsPerWinShootOut = const PointsPerWinShootOut.pure(),
    this.league = League.empty,
    this.category = Category.empty,
    this.shooutOutFlag = false,
    this.cardsflag = false,
    this.categoriesList = const [],
    this.categorySelect = const [],
    this.flagCategorySelect = false,
    this.timeMatchD = "",
    this.allFormIsValid = false,
  });

  CreateTournamentState copyWith({
    String? errorMessage,
    ScreenStatus? screenStatus,
    FormzStatus? formzStatus,
    List<LookUpValue>? lookUpValues,
    LookUpValue? typeTournament,
    Tournament? createTournament,
    TournamentName? tournamentName,
    InscriptionDate? inscriptionDate,
    MaxTeams? maxTeams,
    MaxPlayer? maxPlayer,
    TemporaryReprimands? temporaryReprimands,
    List<LookUpValue>? typeFotbolValues,
    LookUpValue? typeFotbol,
    GamesTimes? gamesTimes,
    DurationByTime? durationByTime,
    BreakNumbers? breakNumbers,
    BreakDuration? breakDuration,
    YellowCardFine? yellowCardFine,
    RedCardFine? redCardFine,
    GamesChanges? gamesChanges,
    PointPerLoss? pointPerLoss,
    PointPerTie? pointPerTie,
    PointPerWin? pointPerWin,
    PointsPerLossShootOut? pointsPerLossShootOut,
    PointsPerWinShootOut? pointsPerWinShootOut,
    League? league,
    Category? category,
    bool? shooutOutFlag,
    bool? cardsflag,
    List<Category>? categoriesList,
    List<CategorySelect>? categorySelect,
    bool? flagCategorySelect,
    String? timeMatchD,
    bool? allFormIsValid,
  }) {
    return CreateTournamentState(
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      formzStatus: formzStatus ?? this.formzStatus,
      lookUpValues: lookUpValues ?? this.lookUpValues,
      typeTournament: typeTournament ?? this.typeTournament,
      createTournament: createTournament ?? this.createTournament,
      tournamentName: tournamentName ?? this.tournamentName,
      inscriptionDate: inscriptionDate ?? this.inscriptionDate,
      maxTeams: maxTeams ?? this.maxTeams,
      maxPlayer: maxPlayer ?? this.maxPlayer,
      temporaryReprimands: temporaryReprimands ?? this.temporaryReprimands,
      typeFotbolValues: typeFotbolValues ?? this.typeFotbolValues,
      typeFotbol: typeFotbol ?? this.typeFotbol,
      gamesTimes: gamesTimes ?? this.gamesTimes,
      durationByTime: durationByTime ?? this.durationByTime,
      breakNumbers: breakNumbers ?? this.breakNumbers,
      breakDuration: breakDuration ?? this.breakDuration,
      yellowCardFine: yellowCardFine ?? this.yellowCardFine,
      redCardFine: redCardFine ?? this.redCardFine,
      gamesChanges: gamesChanges ?? this.gamesChanges,
      pointPerLoss: pointPerLoss ?? this.pointPerLoss,
      pointPerTie: pointPerTie ?? this.pointPerTie,
      pointPerWin: pointPerWin ?? this.pointPerWin,
      pointsPerLossShootOut:
          pointsPerLossShootOut ?? this.pointsPerLossShootOut,
      pointsPerWinShootOut: pointsPerWinShootOut ?? this.pointsPerWinShootOut,
      league: league ?? this.league,
      category: category ?? this.category,
      shooutOutFlag: shooutOutFlag ?? this.shooutOutFlag,
      cardsflag: cardsflag ?? this.cardsflag,
      categoriesList: categoriesList ?? this.categoriesList,
      categorySelect: categorySelect ?? this.categorySelect,
      flagCategorySelect: flagCategorySelect ?? this.flagCategorySelect,
      timeMatchD: timeMatchD ?? this.timeMatchD,
      allFormIsValid: allFormIsValid ?? this.allFormIsValid,
    );
  }

  @override
  List<Object> get props => [
        screenStatus,
        formzStatus,
        lookUpValues,
        createTournament,
        typeTournament,
        tournamentName,
        inscriptionDate,
        maxTeams,
        maxPlayer,
        temporaryReprimands,
        typeFotbolValues,
        typeFotbol,
        gamesTimes,
        durationByTime,
        breakNumbers,
        breakDuration,
        yellowCardFine,
        redCardFine,
        gamesChanges,
        pointPerLoss,
        pointPerTie,
        pointPerWin,
        pointsPerLossShootOut,
        pointsPerWinShootOut,
        league,
        category,
        shooutOutFlag,
        cardsflag,
        categoriesList,
        categorySelect,
        flagCategorySelect,
        timeMatchD,
        allFormIsValid,
      ];
}
