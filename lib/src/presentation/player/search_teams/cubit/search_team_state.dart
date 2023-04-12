part of 'search_team_cubit.dart';

class SearchTeamState extends Equatable {
  // final List<Team> teamList;
  // final int totalElements;
  // final int totalPages;
  // final int currentPage;
  final CommonPageableResponse<Team> teamPageable;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const SearchTeamState({
    // this.totalElements = 0,
    // this.totalPages = 0,
    // this.currentPage = 0,
    // this.teamList = const [],
    this.teamPageable = const CommonPageableResponse<Team>(),
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  SearchTeamState copyWith({
    // List<Team>? teamList,
    // int? totalElements,
    // int? totalPages,
    // int? currentPage,
    CommonPageableResponse<Team>? teamPageable,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return SearchTeamState(
      // teamList: teamList ?? this.teamList,
      // totalElements: totalElements ?? this.totalElements,
      // totalPages: totalPages ?? this.totalPages,
      // currentPage: currentPage ?? this.currentPage,
      teamPageable: teamPageable ?? this.teamPageable,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        // teamList,
        // totalElements,
        // totalPages,
        // currentPage,
        teamPageable,
        screenState,
      ];
}
