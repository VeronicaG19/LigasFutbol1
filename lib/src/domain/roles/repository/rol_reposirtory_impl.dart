import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/entity/user_rol.dart';

import '../../../core/endpoints.dart';
import '../entity/rol.dart';
import 'i_rol_repository.dart';

@LazySingleton(as: IRolRepository)
class RolRepositoryImpl implements IRolRepository {
  final ApiClient _apiClient;

  RolRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Rol>> getRolesByOrgId(int orgIg) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRolesByOrgIdEndpoint/$orgIg',
            converter: Rol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Rol>> getAvailableRolesForUser(int userId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getAvailableRolesForUserEndpoint/$userId',
            converter: Rol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Rol>> getRolesAssociatedToUser(int userId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRolesAssociatedToUserEndpoint/$userId',
            converter: Rol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRol> changePrimaryRol(int userRolId) {
    return _apiClient.network
        .updateData(
            endpoint: '$updatePrimaryRolEndpoint/$userRolId',
            data: {},
            converter: UserRol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRol>> getUserRoles(int userId, int orgId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getUserRolesEndpoint/$orgId/$userId',
            converter: UserRol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRol> createUserRol(UserRol userRol) {
    return _apiClient.network
        .postData(
            endpoint: userRolEndpoint,
            data: userRol.toJson(),
            converter: UserRol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRol> createUserRolAndUpdate(UserRol userRol) {
    return _apiClient.network.updateData(
      endpoint: getUpdateRolSPR, 
      data: userRol.toJsonUpRl(), 
      converter: UserRol.fromJson).validateResponse();
  }

  @override
  RepositoryResponse<UserRol> createUserRolAndUpdateByNames(int personId, String rolName) {
    return _apiClient.network.updateData(
      endpoint: '$getUpdateRolSPR/$personId/$rolName', 
      data: {}, 
      converter: UserRol.fromJson).validateResponse();
  }
}
