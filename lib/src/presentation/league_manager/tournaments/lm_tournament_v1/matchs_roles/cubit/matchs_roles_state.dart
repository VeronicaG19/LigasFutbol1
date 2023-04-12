part of 'matchs_roles_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  rolesCreating,
  rolesCreated
}
class MatchsRolesState extends Equatable {

  final List<MatchRoleDTO> listRoleToGenerate;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final List<TeamTournament> listOfTeams;
  final List<RefereeByLeagueDTO> refereetList;
  final List<Field> fieldtList;
  final ResgisterCountInterface nextRoundNumber;

  const MatchsRolesState({
    this.fieldtList = const [],
    this.refereetList =  const [],
    this.listRoleToGenerate = const [],
    this.listOfTeams = const [],
    this.screenStatus = ScreenStatus.initial,
    this.nextRoundNumber = ResgisterCountInterface.empty,
    this.errorMessage
    });

   MatchsRolesState copyWith({
     List<MatchRoleDTO>? listRoleToGenerate
     ,List<RefereeByLeagueDTO>? refereetList
     ,List<Field>? fieldtList
     ,List<TeamTournament>? listOfTeams
     , ScreenStatus? screenStatus
     ,ResgisterCountInterface? nextRoundNumber
     ,String? errorMessage
   }){
     return MatchsRolesState(
       listRoleToGenerate: listRoleToGenerate ?? this.listRoleToGenerate,
       screenStatus: screenStatus ?? this.screenStatus,
       fieldtList : fieldtList ?? this.fieldtList,
       listOfTeams : listOfTeams ?? this.listOfTeams,
       errorMessage: errorMessage ?? this.errorMessage,
       refereetList : refereetList ?? this.refereetList,
       nextRoundNumber: nextRoundNumber ?? this.nextRoundNumber
     );
   }

  @override
  List<Object> get props => [screenStatus, listRoleToGenerate, listOfTeams , fieldtList, refereetList, nextRoundNumber];
}
