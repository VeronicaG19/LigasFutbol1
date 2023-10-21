part of 'matches_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class MatchesState extends Equatable {
  final List<MatchesByPlayerDTO> matchesList;
  final List<Team> teamList;
  final List<DetailMatchDTO> detailMatchDTO;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final int myTeam;

  const MatchesState({
    this.matchesList = const [],
    this.teamList = const [],
    this.detailMatchDTO = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.myTeam = 0
  });

  MatchesState copyWith({
    List<MatchesByPlayerDTO>? matchesList,
    List<Team>? teamList,
    List<DetailMatchDTO>? detailMatchDTO,
    String? errorMessage,
    ScreenStatus? screenStatus,
    int? myTeam,
  }) {
    return MatchesState(
      matchesList: matchesList ?? this.matchesList,
      teamList: teamList ?? this.teamList,
      detailMatchDTO: detailMatchDTO ?? this.detailMatchDTO,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      myTeam: myTeam ?? this.myTeam
    );
  }

  @override
  List<Object> get props =>
      [matchesList, teamList, detailMatchDTO, screenStatus, myTeam];
}
