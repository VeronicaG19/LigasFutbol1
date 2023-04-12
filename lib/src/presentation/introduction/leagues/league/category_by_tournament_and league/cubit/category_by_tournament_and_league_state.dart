part of 'category_by_tournament_and_league_cubit.dart';

enum ScreenStatus { initial, loading, loaded, error }

class CategoryByTournamentAndLeagueState extends Equatable {
  final List<Category> categoryList;
  final String? errorMessage;
  final Tournament tournamentInfo;
  final ScreenStatus screenStatus;

  const CategoryByTournamentAndLeagueState({
    this.categoryList = const [],
    this.errorMessage,
    this.tournamentInfo = Tournament.empty,
    this.screenStatus = ScreenStatus.initial,
  });

  CategoryByTournamentAndLeagueState copyWith({
    List<Category>? categoryList,
    String? errorMessage,
    Tournament? tournamentInfo,
    ScreenStatus? screenStatus,
  }) {
    return CategoryByTournamentAndLeagueState(
      categoryList: categoryList ?? this.categoryList,
      tournamentInfo: tournamentInfo ?? this.tournamentInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [categoryList, screenStatus, tournamentInfo];
}
