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
  final League leagueManager;
  final League refereeLeague;
  final List<League> refereeLeagues;
  final List<Team> teamManagerTeams;
  final Referee refereeData;
  final Team teamManager;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.locale = const Locale('es', ''),
    this.refereeLeagues = const [],
    this.teamManagerTeams = const [],
    this.refereeData = Referee.empty,
    this.user = User.empty,
    this.leagueManager = League.empty,
    this.refereeLeague = League.empty,
    this.teamManager = Team.empty,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    Locale? locale,
    League? leagueManager,
    League? refereeLeague,
    List<League>? refereeLeagues,
    List<Team>? teamManagerTeams,
    Referee? refereeData,
    Team? teamManager,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      locale: locale ?? this.locale,
      leagueManager: leagueManager ?? this.leagueManager,
      refereeLeague: refereeLeague ?? this.refereeLeague,
      refereeLeagues: refereeLeagues ?? this.refereeLeagues,
      teamManagerTeams: teamManagerTeams ?? this.teamManagerTeams,
      refereeData: refereeData ?? this.refereeData,
      teamManager: teamManager ?? this.teamManager,
    );
  }

  @override
  List<Object> get props => [
        status,
        user,
        locale,
        leagueManager,
        refereeLeague,
        refereeLeagues,
        teamManagerTeams,
        refereeData,
        teamManager,
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
