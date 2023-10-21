part of 'matchs_l_roles_cubit.dart';

class MatchesLRolesState extends Equatable {
  final String round;
  final int roundCount;
  final List<List<TeamTournament>> listOfTeams;
  final List<TeamTournament> tmsSelected;
  final BasicCubitScreenState screenStatus;
  final String? errorMessage;

  const MatchesLRolesState({
    this.round = '',
    this.roundCount = 0,
    this.listOfTeams = const [],
    this.screenStatus = BasicCubitScreenState.initial,
    this.errorMessage,
    this.tmsSelected = const [],
  });

  MatchesLRolesState copyWith({
    List<List<TeamTournament>>? listOfTeams,
    BasicCubitScreenState? screenStatus,
    int? roundCount,
    String? errorMessage,
    String? round,
    List<TeamTournament>? tmsSelected,
  }) {
    return MatchesLRolesState(
        listOfTeams: listOfTeams ?? this.listOfTeams,
        round: round ?? this.round,
        roundCount: roundCount ?? this.roundCount,
        screenStatus: screenStatus ?? this.screenStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        tmsSelected: tmsSelected ?? this.tmsSelected);
  }

  @override
  List<Object?> get props =>
      [round, listOfTeams, roundCount, screenStatus, tmsSelected];
}
