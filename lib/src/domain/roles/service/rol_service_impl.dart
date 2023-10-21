import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/entity/user_rol.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/service/i_rol_service.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/typedefs.dart';
import '../entity/rol.dart';
import '../repository/i_rol_repository.dart';

@LazySingleton(as: IRolService)
class RolServiceImpl implements IRolService {
  final IRolRepository _repository;

  RolServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Rol>> getRolesByOrgId(int orgIg) {
    return _repository.getRolesByOrgId(orgIg);
  }

  @override
  Future<List<Rol>> getAvailableRolesForUser(int userId) async {
    final response = await _repository.getAvailableRolesForUser(userId);
    return response.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<List<Rol>> getRolesAssociatedToUser(int userId) {
    return _repository.getRolesAssociatedToUser(userId);
  }

  @override
  Future<UserRol> getPrimaryRol(List<UserRol> roles) async {
    final rol = roles.isNotEmpty
        ? roles.firstWhere((element) => element.primaryFlag == 'Y')
        : UserRol.empty;
    final player = roles.isNotEmpty
        ? roles.firstWhere((element) => element.rol.roleId == 17)
        : UserRol.empty;
    return await _validatePlatformRol(rol, player.userRolId);
  }

  Future<UserRol> _validatePlatformRol(
      final UserRol rol, final int defaultRol) async {
    final roleId = rol.rol.roleId;
    if (kIsWeb) {
      if (roleId != 17 && roleId != 18 && roleId != 19) {
        final newRol = await changePrimaryRol(defaultRol);
        return newRol.getOrElse(() => UserRol.empty);
      }
      return rol;
    } else {
      if (roleId != 17 && roleId != 20 && roleId != 22 && roleId != 23) {
        final newRol = await changePrimaryRol(defaultRol);
        return newRol.getOrElse(() => UserRol.empty);
      }
      return rol;
    }
  }

  @override
  ApplicationRol getApplicationRol(String rol) {
    switch (rol) {
      case 'PLAYER':
        return ApplicationRol.player;
      case 'LEAGUE_MANAGER':
        return ApplicationRol.leagueManager;
      case 'SUPER_ADMIN':
        return ApplicationRol.superAdmin;
      case 'REFEREE':
        return ApplicationRol.referee;
      case 'REFEREE_MANAGER':
        return ApplicationRol.refereeManager;
      case 'TEAM_MANAGER':
        return ApplicationRol.teamManager;
      case 'FIELD_OWNER':
        return ApplicationRol.fieldOwner;
      default:
        return ApplicationRol.player;
    }
  }

  @override
  RepositoryResponse<UserRol> changePrimaryRol(int userRolId) {
    return _repository.changePrimaryRol(userRolId);
  }

  @override
  RepositoryResponse<List<UserRol>> getUserRoles(int userId, int orgId) {
    return _repository.getUserRoles(userId, orgId);
  }

  @override
  RepositoryResponse<UserRol> createUserRol(UserRol userRol) {
    return _repository.createUserRol(userRol);
  }

  @override
  RepositoryResponse<UserRol> createUserRolAndUpdate(UserRol userRol) {
    return _repository.createUserRolAndUpdate(userRol);
  }

  @override
  RepositoryResponse<UserRol> createUserRolAndUpdateByNames(
      int personId, String rolName) {
    return _repository.createUserRolAndUpdateByNames(personId, rolName);
  }
}
