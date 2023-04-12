import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/environment_config.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/service/i_rol_service.dart';
import 'package:ligas_futbol_flutter/src/domain/user_configuration/service/i_user_configuration_service.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/roles/entity/rol.dart';
import '../../../../../domain/roles/entity/user_rol.dart';
import '../../../../../domain/user_configuration/entity/user_configuration.dart';
import '../../../../../domain/user_requests/dto/request_to_admin_dto.dart';
import '../../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'role_state.dart';

@injectable
class RoleCubit extends Cubit<RoleState> {
  RoleCubit(this._rolService, this._configurationService, this._requestService)
      : super(const RoleState());

  final IUserConfigurationService _configurationService;
  final IRolService _rolService;
  final IUserRequestsService _requestService;

  Future<void> loadInitialData(int userId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final userRoles = await _configurationService.getUserConfiguration(userId);
    final applicationRoles =
        await _rolService.getRolesByOrgId(EnvironmentConfig.orgId);
    List<Rol> availableRoles = applicationRoles.getOrElse(() => []);
    for (final r in userRoles) {
      availableRoles.removeWhere((element) => element.roleId == r.rol.roleId);
    }
    final currentRole = _rolService.getPrimaryRol(userRoles);
    emit(state.copyWith(
        rolChanged: _rolService.getApplicationRol(currentRole.rol.roleName),
        screenState: BasicCubitScreenState.loaded,
        currentRol: currentRole,
        associatedRoles: userRoles,
        availableRoles: availableRoles));
  }

  Future<void> changeRol(int index) async {
    final rol = state.associatedRoles.elementAt(index);
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _rolService.changePrimaryRol(rol.userRolId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.loaded,
            errorMessage: l.errorMessage)),
        (r) => emit(state.copyWith(
            screenState: BasicCubitScreenState.loaded,
            currentRol: r,
            rolChanged: _rolService.getApplicationRol(r.rol.roleName))));
  }

  bool getIsRolAssociated(Rolesnm role) {
    bool dta = false;
    for (var element in state.associatedRoles) {
      if (element.rol.roleName == role.name) {
        dta = true;
      }
    }
    return dta;
  }

  bool validateFieldOwnerVisibility() {
    if (state.currentRol.rol.roleName == Rolesnm.FIELD_OWNER.name) {
      return false;
    }
    final roles = state.associatedRoles.map((e) => e.rol.roleName).toList();
    return !(roles.contains(Rolesnm.LEAGUE_MANAGER.name) ||
        roles.contains(Rolesnm.FIELD_OWNER.name));
  }

  ///Envia una solicitud para convertirse en dueño de campo
  Future<void> sendRequestForFieldOwner(User user) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.validating));
    final request = RequestToAdmonDTO(
        leagueName: user.userName,
        leagueDescription: 'Campo de juego',
        partyId: user.person.personId,
        status: 0);
    final response = await _requestService.sendRequestToFieldOwner(request);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.code)), (r) async {
      final userRol = UserRol(
          primaryFlag: 'N',
          rol: Rol(
              orgId: EnvironmentConfig.orgId,
              roleName: 'FIELD_OWNER',
              roleId: 23),
          configuration: UserConfiguration.empty,
          userRolId: 0,
          user: user.copyWith(id: user.id));
      await _rolService.createUserRol(userRol);
      emit(state.copyWith(screenState: BasicCubitScreenState.success));
    });
  }

  Future<void> getFieldOwnerRequestStatus(int? personId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.validating));
    final response =
        await _requestService.getRequestByStatusAndType(personId ?? 0, 3, 13);
    response.fold(
        (l) => emit(state.copyWith(screenState: BasicCubitScreenState.loaded)),
        (r) => emit(state.copyWith(
            screenState: r.isEmpty
                ? BasicCubitScreenState.loaded
                : BasicCubitScreenState.invalidData)));
  }
}
