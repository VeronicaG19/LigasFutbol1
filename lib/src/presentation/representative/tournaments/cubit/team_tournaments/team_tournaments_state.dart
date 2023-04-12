part of 'team_tournaments_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TeamTournamentsState extends Equatable {
  final List<TournamentByTeamDTO> tournamentsList;
  final List<LookUpValue> footballTypeList;
  final LookUpValue footballType;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TeamTournamentsState({
    this.tournamentsList = const [],
    this.footballTypeList = const [],
    this.footballType = LookUpValue.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });


  TeamTournamentsState copyWith({
    List<TournamentByTeamDTO>? tournamentsList,
    List<LookUpValue>? footballTypeList,
    LookUpValue? footballType,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TeamTournamentsState(
      tournamentsList: tournamentsList ?? this.tournamentsList,
      footballTypeList: footballTypeList ?? this.footballTypeList,
      footballType: footballType ?? this.footballType,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [tournamentsList, screenStatus];
}
