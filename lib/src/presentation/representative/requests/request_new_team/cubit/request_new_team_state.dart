part of 'request_new_team_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  loadingCategories,
  teamCreated,
  error,
}

class RequestNewTeamState extends Equatable {
  final List<Category> categoryList;
  final List<League> leagueList;
  final Category categorySelect;
  final League leagueSelect;
  final CategoryId categoryId;
  final LeagueId leagueId;
  final TeamName teamName;
  final FormzStatus formzStatus;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RequestNewTeamState({
    this.categoryList = const [],
    this.leagueList = const [],
    this.categorySelect = Category.empty,
    this.leagueSelect = League.empty,
    this.categoryId = const CategoryId.pure(),
    this.leagueId = const LeagueId.pure(),
    this.teamName = const TeamName.pure(),
    this.formzStatus = FormzStatus.pure,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RequestNewTeamState copyWith({
    List<Category>? categoryList,
    List<League>? leagueList,
    Category? categorySelect,
    League? leagueSelect,
    CategoryId? categoryId,
    LeagueId? leagueId,
    TeamName? teamName,
    FormzStatus? formzStatus,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RequestNewTeamState(
      categoryList: categoryList ?? this.categoryList,
      leagueList: leagueList ?? this.leagueList,
      categorySelect: categorySelect ?? this.categorySelect,
      leagueSelect: leagueSelect ?? this.leagueSelect,
      categoryId: categoryId ?? this.categoryId,
      leagueId: leagueId ?? this.leagueId,
      teamName: teamName ?? this.teamName,
      formzStatus: formzStatus ?? this.formzStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
        categoryList,
        leagueList,
        categorySelect,
        leagueSelect,
        categoryId,
        leagueId,
        teamName,
        formzStatus,
        screenStatus,
      ];
}
