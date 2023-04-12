import '../../../core/typedefs.dart';
import '../../roles/entity/user_rol.dart';
import '../entity/user_configuration.dart';

abstract class IUserConfigurationRepository {
  RepositoryResponse<UserConfiguration> createUserConfiguration(
      UserConfiguration configuration);
  RepositoryResponse<UserConfiguration> updateUserConfiguration(
      UserConfiguration configuration);
  RepositoryResponse<UserConfiguration> deleteUserConfiguration(int id);
  RepositoryResponse<List<UserRol>> getUserConfiguration(int userId);
  RepositoryResponse<UserConfiguration> getUserConfigurationByUserRolId(
      int userRolId);
}
