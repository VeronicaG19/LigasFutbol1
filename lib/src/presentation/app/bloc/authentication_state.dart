part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  loading,
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  final Locale locale;
  final List<League> managerLeagues;
  final League selectedLeague;
  final Team selectedTeam;
  final League refereeLeague;
  final List<League> refereeLeagues;
  final List<Team> teamManagerTeams;
  final Referee refereeData;

  final Player playerData;
  final bool isUpdating;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.locale = const Locale('es', ''),
    this.refereeLeagues = const [],
    this.teamManagerTeams = const [],
    this.managerLeagues = const [],
    this.refereeData = Referee.empty,
    this.user = User.empty,
    this.selectedLeague = League.empty,
    this.selectedTeam = Team.empty,
    this.refereeLeague = League.empty,
    this.playerData = Player.empty,
    this.isUpdating = false,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    Locale? locale,
    League? selectedLeague,
    Team? selectedTeam,
    League? refereeLeague,
    List<League>? refereeLeagues,
    List<Team>? teamManagerTeams,
    List<League>? managerLeagues,
    Referee? refereeData,
    Player? playerData,
    bool? isUpdating,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      locale: locale ?? this.locale,
      selectedLeague: selectedLeague ?? this.selectedLeague,
      selectedTeam: selectedTeam ?? this.selectedTeam,
      managerLeagues: managerLeagues ?? this.managerLeagues,
      refereeLeague: refereeLeague ?? this.refereeLeague,
      refereeLeagues: refereeLeagues ?? this.refereeLeagues,
      teamManagerTeams: teamManagerTeams ?? this.teamManagerTeams,
      refereeData: refereeData ?? this.refereeData,
      playerData: playerData ?? this.playerData,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object> get props => [
        status,
        user,
        locale,
        selectedLeague,
        selectedTeam,
        managerLeagues,
        refereeLeague,
        refereeLeagues,
        teamManagerTeams,
        refereeData,
        playerData,
        isUpdating,
      ];
// /// Convert a JSON object into a [AuthenticationState] Model.
// factory AuthenticationState.fromJson(Map<String, dynamic> json) {
//   final AuthenticationStatus status =
//       AuthenticationStatus.values.elementAt(json['status']);
//   if (status == AuthenticationStatus.tacPendant) {
//     return AuthenticationState.tacPendant(
//         User.fromJson(json['user']), Locale(json['locale']));
//   } else if (status == AuthenticationStatus.authenticated) {
//     final user = User.fromJson(json['user']);
//     final rol = user.defineApplicationRoleFromToken();
//     return AuthenticationState.authenticated(
//         user.copyWith(applicationRole: rol), Locale(json['locale']));
//   } else {
//     return AuthenticationState.unauthenticated(Locale(json['locale']));
//   }
// }
//
// /// convert a [AuthenticationState] model to JSON object.
// Map<String, dynamic> toJson() {
//   return {
//     "status": status.index,
//     "user": user.toJsonBlocSession(),
//     "locale": locale.languageCode,
//   };
// }
}
