import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/repository/i_player_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/entity/rol.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/entity/user_rol.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/service/i_rol_service.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../environment_config.dart';
import '../../../domain/leagues/leagues.dart';
import '../../../domain/referee/entity/referee.dart';
import '../../../domain/referee/service/i_referee_service.dart';
import '../../../domain/team/entity/team.dart';
import '../../../domain/user_configuration/entity/user_configuration.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      this._authenticationRepository,
      this._userRepository,
      this._rolService,
      this._leagueService,
      this._refereeService,
      this._teamService,
      this._notificationRepository,
      this._playerRepository)
      : super(const AuthenticationState()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationRolChanged>(_onAuthenticationRolChanged);
    on<UpdateUserData>(_onUserDataChanged);
    on<ChangeRefereeLeagueEvent>(_onChangeRefereeLeagueEvent);
    on<UpdateUserProfileImage>(_onUpdateUserProfileImage);
    on<ChangeTeamManagerTeamEvent>(_onChangeTeamManagerTeamEvent);
    on<UpdateLeagueManagerLeagues>(_onUpdateLeagueManagerLeagues);
    on<ChangeSelectedLeague>(_onChangeSelectedLeague);
    on<ChangeSelectedTeam>(_onChangeSelectedTeam);
    on<UpdateTeamList>(_onUpdateTeams);
    on<UpdateRefereeData>(_onUpdateRefereeData);
    _authenticationStatusSubscription =
        _authenticationRepository.sessionStream.listen(
      (oauth) => add(AuthenticationStatusChanged(oauth)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final IRolService _rolService;
  final ILeagueService _leagueService;
  final ITeamService _teamService;
  final IRefereeService _refereeService;
  late StreamSubscription<String> _authenticationStatusSubscription;
  final NotificationRepository _notificationRepository;
  final IPlayerRepository _playerRepository;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emmit) async {
    if (event.token.isNotEmpty) {
      emmit(state.copyWith(
          status: AuthenticationStatus.unknown,
          user: state.user.copyWith(applicationRol: ApplicationRol.unknown)));

      final user = await _tryToGetUser();
      final rol = await _getPrimaryRol(user.id ?? 0);
      final leagues = await _getLeagueManagerData(user.person.personId ?? 0);
      final teams = await _getTeamManagerTeams(user.person.personId ?? 0);
      final teamM = rol == ApplicationRol.teamManager
          ? await _getTeamManagerTeams(user.person.personId ?? 0)
          : const <Team>[];
      final refereeData = await _getRefereeData(
          user.person.personId ?? 0, user.person.getFullName);
      final playerData = await _getPlayerInfo(user.person.personId ?? 0);
      // final refereeLeagues =
      //     await _getRefereeLeagues(refereeData.refereeId ?? 0);
      // final refereeLeague =
      //     refereeLeagues.isNotEmpty ? refereeLeagues.first : League.empty;
      emmit(state.copyWith(
          status: user == User.empty
              ? AuthenticationStatus.unauthenticated
              : AuthenticationStatus.authenticated,
          user: user.copyWith(applicationRol: rol),
          managerLeagues: leagues,
          selectedLeague: leagues.isNotEmpty ? leagues.first : League.empty,
          selectedTeam: teams.isNotEmpty ? teams.first : Team.empty,
          refereeData: refereeData,
          playerData: playerData,
          // refereeLeague: refereeLeague,
          // refereeLeagues: refereeLeagues,
          teamManagerTeams: teamM));
      await _onSaveFCMToken(user.person.personId ?? 0);
      await _onGetLocations();
    } else {
      emmit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emmit) async {
    _onDeleteFCMToken();
    emmit(
        state.copyWith(status: AuthenticationStatus.unknown, user: User.empty));
    await Future.delayed(const Duration(seconds: 1));
    _authenticationRepository.logOut();
  }

  Future<User> _tryToGetUser() async {
    final request = await _userRepository.getUserDataByUserName();
    return request.fold((l) => User.empty, (r) => r);
  }

  Future<void> _onAuthenticationRolChanged(AuthenticationRolChanged event,
      Emitter<AuthenticationState> emmit) async {
    if (event.applicationRol == ApplicationRol.player &&
        state.playerData.isEmpty) {
      final playerData = await _getPlayerInfo(state.user.person.personId ?? 0);
      emmit(state.copyWith(
          user: state.user.copyWith(applicationRol: event.applicationRol),
          playerData: playerData));
    }
    if (event.applicationRol == ApplicationRol.referee &&
        state.refereeData.isEmpty) {
      final refereeData = await _getRefereeData(
          state.user.person.personId ?? 0, state.user.person.getFullName);
      emmit(state.copyWith(
          user: state.user.copyWith(applicationRol: event.applicationRol),
          refereeData: refereeData));
    }
    if (event.applicationRol == ApplicationRol.teamManager) {
      final teamM = await _getTeamManagerTeams(state.user.person.personId ?? 0);
      emmit(state.copyWith(
          user: state.user.copyWith(applicationRol: event.applicationRol),
          selectedTeam: teamM.isEmpty ? Team.empty : teamM.first,
          teamManagerTeams: teamM));
    }
    if (state.selectedLeague == League.empty &&
        (event.applicationRol == ApplicationRol.leagueManager ||
            event.applicationRol == ApplicationRol.fieldOwner)) {
      final leagueM =
          await _getLeagueManagerData(state.user.person.personId ?? 0);
      emmit(state.copyWith(
          user: state.user.copyWith(applicationRol: event.applicationRol),
          managerLeagues: leagueM,
          selectedLeague: leagueM.isNotEmpty ? leagueM.first : League.empty));
    }
    emmit(state.copyWith(
        user: state.user.copyWith(applicationRol: event.applicationRol)));
  }

  Future<ApplicationRol> _getPrimaryRol(int userId) async {
    final request =
        await _rolService.getUserRoles(userId, EnvironmentConfig.orgId);
    return request.fold(
        (l) async => await _createUserRol(userId),
        (r) async => r.isEmpty
            ? await _createUserRol(userId)
            : await _validateCurrentRol(r));
  }

  Future<ApplicationRol> _validateCurrentRol(final List<UserRol> roles) async {
    final primaryRol = await _rolService.getPrimaryRol(roles);
    return _rolService.getApplicationRol(primaryRol.rol.roleName);
  }

  Future<ApplicationRol> _createUserRol(int userId) async {
    const user = User.empty;
    final userRol = UserRol(
        primaryFlag: 'Y',
        rol:
            Rol(orgId: EnvironmentConfig.orgId, roleName: 'PLAYER', roleId: 17),
        configuration: UserConfiguration.empty,
        userRolId: 0,
        user: user.copyWith(id: userId));
    await _rolService.createUserRol(userRol);
    return ApplicationRol.player;
  }

  Future<List<League>> _getLeagueManagerData(int personId) async {
    return await _leagueService.getManagerLeagues(personId);
  }

  Future<League> _getTournamentLeagueManagerData(int personId) async {
    final request = await _leagueService.getManagerLeagues(personId);
    if (request.isEmpty) {
      return League.empty;
    }
    return request.first;
  }

  Future<List<Team>> _getTeamManagerTeams(int personId) async {
    final request = await _teamService.getManagerTeams(personId);
    return request;
  }

  void _onUpdateTeams(
      UpdateTeamList event, Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(status: AuthenticationStatus.unknown));
    final user = await _tryToGetUser();
    await Future.delayed(const Duration(seconds: 1));
    final teamM = await _getTeamManagerTeams(user.person.personId ?? 0);
    await Future.delayed(const Duration(seconds: 1));

    emitter(state.copyWith(
        status: AuthenticationStatus.authenticated, teamManagerTeams: teamM));
  }

  // Future<List<League>> _getRefereeLeagues(int refereeId) async {
  //   return await _leagueService.getRefereeLeagues(refereeId);
  // }

  Future<Player> _getPlayerInfo(int partyId) async {
    final request = await _playerRepository.getDataPlayerByPartyId(partyId);
    return request.fold((l) => Player.empty, (r) => r);
  }

  Future<Referee> _getRefereeData(int personId, String personName) async {
    final request =
        await _refereeService.getRefereeDataByPersonId(personId, personName);
    return request;
  }

  void _onUserDataChanged(
      UpdateUserData event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(user: event.user));
  }

  void _onUpdateRefereeData(
      UpdateRefereeData event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(refereeData: event.referee));
  }

  void _onChangeRefereeLeagueEvent(
      ChangeRefereeLeagueEvent event, Emitter<AuthenticationState> emitter) {
    emitter(state.copyWith(refereeLeague: event.league));
  }

  void _onUpdateLeagueManagerLeagues(UpdateLeagueManagerLeagues event,
      Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(status: AuthenticationStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    List<League> leagues = state.managerLeagues;
    emitter(state.copyWith(managerLeagues: []));
    leagues.remove(event.league);
    emitter(state.copyWith(
        managerLeagues: leagues,
        selectedLeague: leagues.isNotEmpty ? leagues.first : League.empty,
        status: AuthenticationStatus.authenticated));
  }

  void _onChangeSelectedLeague(
      ChangeSelectedLeague event, Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(status: AuthenticationStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emitter(state.copyWith(
        selectedLeague: event.league,
        status: AuthenticationStatus.authenticated));
  }

  void _onChangeSelectedTeam(
      ChangeSelectedTeam event, Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(
        status: AuthenticationStatus.loading,
        selectedTeam: Team.empty.copyWith(teamId: -1)));
    await Future.delayed(const Duration(seconds: 1));
    emitter(state.copyWith(
        selectedTeam: event.team, status: AuthenticationStatus.authenticated));
  }

  Future<void> _onChangeTeamManagerTeamEvent(ChangeTeamManagerTeamEvent event,
      Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(selectedTeam: Team.empty.copyWith(teamId: -1)));
    await Future.delayed(const Duration(seconds: 1));
    emitter(state.copyWith(selectedTeam: event.team));
  }

  void _onUpdateUserProfileImage(UpdateUserProfileImage event,
      Emitter<AuthenticationState> emitter) async {
    emitter(state.copyWith(isUpdating: true));

    final list =
        await event.file?.readAsBytes() ?? await event.xFile?.readAsBytes();
    final photo = base64Encode(list!);
    final person = state.user.person.copyWith(photo: photo);
    final request = await _userRepository
        .updatePersonData(state.user.copyWith(person: person));
    request.fold(
      (l) => null,
      (r) => emitter(state.copyWith(
        user: r,
        isUpdating: false,
      )),
    );
  }

  Future<void> _onSaveFCMToken(int personId) async {
    final permissionStatus = await Permission.notification.status;

    if (permissionStatus.isRestricted) {
      await Permission.notification.request();
    }
    final appId = AppId(
      appId: EnvironmentConfig.orgId,
      appName: EnvironmentConfig.appName,
    );
    _notificationRepository.postDeviceData(personId, appId);
  }

  Future<void> _onGetLocations() async {
    if (await Permission.location.isRestricted ||
        await Permission.location.isDenied ||
        await Permission.location.isPermanentlyDenied) {
      await Permission.location.request();
    }
  }

  void _onDeleteFCMToken() {
    _notificationRepository.deleteDeviceData(state.user.person.personId ?? 0);
  }
}
