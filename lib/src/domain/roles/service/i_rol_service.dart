import 'package:user_repository/user_repository.dart';

import '../../../core/typedefs.dart';
import '../entity/rol.dart';
import '../entity/user_rol.dart';

abstract class IRolService {
  RepositoryResponse<List<Rol>> getRolesByOrgId(int orgIg);
  Future<List<Rol>> getAvailableRolesForUser(int userId);
  RepositoryResponse<List<Rol>> getRolesAssociatedToUser(int userId);
  RepositoryResponse<List<UserRol>> getUserRoles(int userId, int orgId);
  Future<UserRol> getPrimaryRol(List<UserRol> roles);
  ApplicationRol getApplicationRol(String rol);
  RepositoryResponse<UserRol> changePrimaryRol(int userRolId);
  RepositoryResponse<UserRol> createUserRol(UserRol userRol);
  RepositoryResponse<UserRol> createUserRolAndUpdate(UserRol userRol);

  RepositoryResponse<UserRol> createUserRolAndUpdateByNames(
      int personId, String rolName);
}
