part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticationRolChanged extends AuthenticationEvent {
  final ApplicationRol applicationRol;
  const AuthenticationRolChanged(this.applicationRol);

  @override
  List<Object?> get props => [applicationRol];
}

class UpdateUserData extends AuthenticationEvent {
  final User user;
  const UpdateUserData(this.user);

  @override
  List<Object?> get props => [user];
}

class ChangeRefereeLeagueEvent extends AuthenticationEvent {
  const ChangeRefereeLeagueEvent(this.league);
  final League league;

  @override
  List<Object?> get props => [league];
}

class ChangeTeamManagerTeamEvent extends AuthenticationEvent {
  const ChangeTeamManagerTeamEvent(this.team);
  final Team team;

  @override
  List<Object?> get props => [team];
}

class UpdateUserProfileImage extends AuthenticationEvent {
  final CroppedFile? file;
  final XFile? xFile;
  const UpdateUserProfileImage({this.file, this.xFile});

  @override
  List<Object?> get props => [file, xFile];
}

class UpdateRefereeData extends AuthenticationEvent {
  final Referee referee;
  const UpdateRefereeData(this.referee);

  @override
  List<Object?> get props => [referee];
}

/*class AuthenticationUserDataChanged extends AuthenticationEvent {
  const AuthenticationUserDataChanged(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class ToggleLanguageEvent extends AuthenticationEvent {
  const ToggleLanguageEvent(this.languageCode);
  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

class ConfirmInitialAdvice extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}*/
