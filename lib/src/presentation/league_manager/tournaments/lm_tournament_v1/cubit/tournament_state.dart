part of 'tournament_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  changeTournament,
  changeCategory,
  tournamentLoading,
  tournamentLoaded,
  changedTournament,
  tournamentDeleted,
}

class TournamentState extends Equatable {
  final List<Category> categories;
  final List<Tournament> tournaments;
  final Tournament tournamentSelected;
  final List<Days> daysList;
  final List<LookUpValue> lookUpValues;
  final List<LookUpValue> typeOfGames;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final int? indexCatSelec;
  //final EmailInput emailInput;

  const TournamentState(
      {this.categories = const [],
      this.screenStatus = ScreenStatus.initial,
      this.errorMessage,
      this.tournaments = const [],
      this.lookUpValues = const [],
      this.indexCatSelec = 0,
      this.tournamentSelected = Tournament.empty,
      this.typeOfGames = const [],
      this.daysList = const []});

  @override
  List<Object?> get props => [
        screenStatus,
        categories,
        tournaments,
        indexCatSelec,
        lookUpValues,
        tournamentSelected,
        typeOfGames,
        daysList
      ];

  TournamentState copyWith(
      {List<Category>? categories,
      String? errorMessage,
      ScreenStatus? screenStatus,
      int? indexCatSelec,
      List<Tournament>? tournaments,
      List<LookUpValue>? lookUpValues,
      Tournament? tournamentSelected,
      List<LookUpValue>? typeOfGames,
      List<Days>? daysList}) {
    return TournamentState(
        categories: categories ?? this.categories,
        errorMessage: errorMessage ?? this.errorMessage,
        screenStatus: screenStatus ?? this.screenStatus,
        tournaments: tournaments ?? this.tournaments,
        indexCatSelec: indexCatSelec ?? this.indexCatSelec,
        lookUpValues: lookUpValues ?? this.lookUpValues,
        tournamentSelected: tournamentSelected ?? this.tournamentSelected,
        typeOfGames: typeOfGames ?? this.typeOfGames,
        daysList: daysList ?? this.daysList);
  }
}
