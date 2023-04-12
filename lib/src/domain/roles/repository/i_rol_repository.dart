import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/rol.dart';
import '../entity/user_rol.dart';

abstract class IRolRepository {
  RepositoryResponse<List<Rol>> getRolesByOrgId(int orgIg);
  RepositoryResponse<List<Rol>> getAvailableRolesForUser(int userId);
  RepositoryResponse<List<Rol>> getRolesAssociatedToUser(int userId);
  RepositoryResponse<UserRol> changePrimaryRol(int userRolId);
  RepositoryResponse<List<UserRol>> getUserRoles(int userId, int orgId);
  RepositoryResponse<UserRol> createUserRol(UserRol userRol);
  RepositoryResponse<UserRol> createUserRolAndUpdate(UserRol userRol);

  RepositoryResponse<UserRol> createUserRolAndUpdateByNames(int personId, String rolName);
}
