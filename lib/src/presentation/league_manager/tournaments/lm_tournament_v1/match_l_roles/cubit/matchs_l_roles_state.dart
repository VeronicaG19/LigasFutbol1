part of 'matchs_l_roles_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  rolesCreating,
  rolesCreated
}

class MatchsLRolesState extends Equatable {

  final List<TeamTournament> listOfTeams;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final List<MatchTeamMatchesRefereeDTO> listRoleToGenerate;

  const MatchsLRolesState({
    this.listOfTeams = const [],
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.listRoleToGenerate = const [],
  });

  MatchsLRolesState copyWith({
    List<TeamTournament>? listOfTeams,
    ScreenStatus? screenStatus,
    String? errorMessage,
    List<MatchTeamMatchesRefereeDTO>? listRoleToGenerate,
  }){
    return MatchsLRolesState(
      listOfTeams : listOfTeams ?? this.listOfTeams,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      listRoleToGenerate: listRoleToGenerate ?? this.listRoleToGenerate,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [listOfTeams ,screenStatus,listRoleToGenerate];
}
