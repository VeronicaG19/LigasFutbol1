part of 'search_team_cubit.dart';

class SearchTeamState extends Equatable {
  // final List<Team> teamList;
  // final int totalElements;
  // final int totalPages;
  // final int currentPage;
  final Category catSelect;
  final List<Category> categoriesList;
  final League leageSlct;
  final CommonPageableResponse<Team> teamPageable;
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  final List<League> leages;
  final String requestPlayers;

  const SearchTeamState({ 
    // this.totalElements = 0,
    // this.totalPages = 0,
    // this.currentPage = 0,
    this.requestPlayers = 'N',
    this.catSelect = Category.empty,
    this.categoriesList = const [],
    this.leageSlct = League.empty,
    this.leages = const [],
    this.teamPageable = const CommonPageableResponse<Team>(),
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  SearchTeamState copyWith({
    // List<Team>? teamList,
    // int? totalElements,
    // int? totalPages,
    // int? currentPage,
    String? requestPlayers,
    Category? catSelect,
    List<Category>? categoriesList,
    League? leageSlct,
    List<League>? leages,
    CommonPageableResponse<Team>? teamPageable,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return SearchTeamState(
      // teamList: teamList ?? this.teamList,
      // totalElements: totalElements ?? this.totalElements,
      // totalPages: totalPages ?? this.totalPages,
      // currentPage: currentPage ?? this.currentPage,
      requestPlayers: requestPlayers ?? this.requestPlayers,
      catSelect: catSelect ?? this.catSelect,
      categoriesList: categoriesList ?? this.categoriesList,
      leageSlct: leageSlct ?? this.leageSlct,
      teamPageable: teamPageable ?? this.teamPageable,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
      leages: leages ?? this.leages
    );
  }

  @override
  List<Object?> get props => [
        // teamList,
        // totalElements,
        // totalPages,
        // currentPage,
        requestPlayers,
        leageSlct,
        categoriesList,
        catSelect,
        leages,
        teamPageable,
        screenState,
      ];
}
