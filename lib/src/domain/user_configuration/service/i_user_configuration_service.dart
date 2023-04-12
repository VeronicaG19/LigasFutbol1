import '../../../core/typedefs.dart';
import '../../roles/entity/user_rol.dart';
import '../entity/user_configuration.dart';

abstract class IUserConfigurationService {
  RepositoryResponse<UserConfiguration> createUserConfiguration(
      UserConfiguration configuration);
  RepositoryResponse<UserConfiguration> updateUserConfiguration(
      UserConfiguration configuration);
  RepositoryResponse<UserConfiguration> deleteUserConfiguration(int id);
  Future<List<UserRol>> getUserConfiguration(int userId);
  UserRol getPrimaryConfiguration(List<UserRol> roles);
}
