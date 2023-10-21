part of 'statics_cubit.dart';

enum RefereeStaticsScreenState {
  initial,
  loadingLeagues,
  loadingGlobalStatics,
  emptyLeaguesList,
  leaguesLoaded,
  globalStaticsLoaded,
  error
}

class StaticsState extends Equatable {
  // final List<RefereeStatics> refereeStatics;
  // final List<CountEventTournament> events;
  // final List<Category> categories;
  // final List<Tournament> tournaments;
  // final Category selectedCategory;
  // final Tournament selectedTournament;
  final List<League> refereeLeagues;
  final League selectedLeague;
  final RefereeStaticsScreenState screenState;
  final RefereeGlobalStatics globalStatics;
  final String? errorMessage;

  const StaticsState({
    // this.refereeStatics = const [],
    // this.categories = const [],
    // this.tournaments = const [],
    // this.events = const [],
    // this.selectedCategory = Category.empty,
    // this.selectedTournament = Tournament.empty,
    this.refereeLeagues = const [],
    this.globalStatics = RefereeGlobalStatics.empty,
    this.selectedLeague = League.empty,
    this.screenState = RefereeStaticsScreenState.initial,
    this.errorMessage,
  });

  StaticsState copyWith({
    // List<RefereeStatics>? refereeStatics,
    // List<Category>? categories,
    // List<Tournament>? tournaments,
    // List<CountEventTournament>? events,
    // Category? selectedCategory,
    // Tournament? selectedTournament,
    List<League>? refereeLeagues,
    League? selectedLeague,
    RefereeStaticsScreenState? screenState,
    RefereeGlobalStatics? globalStatics,
    String? errorMessage,
  }) {
    return StaticsState(
      // refereeStatics: refereeStatics ?? this.refereeStatics,
      // categories: categories ?? this.categories,
      // tournaments: tournaments ?? this.tournaments,
      // selectedCategory: selectedCategory ?? this.selectedCategory,
      // selectedTournament: selectedTournament ?? this.selectedTournament,
      // events: events ?? this.events,
      refereeLeagues: refereeLeagues ?? this.refereeLeagues,
      selectedLeague: selectedLeague ?? this.selectedLeague,
      screenState: screenState ?? this.screenState,
      globalStatics: globalStatics ?? this.globalStatics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        // refereeStatics,
        // categories,
        // tournaments,
        // selectedCategory,
        // events,
        // selectedTournament,
        refereeLeagues,
        selectedLeague,
        globalStatics,
        screenState,
      ];
}
