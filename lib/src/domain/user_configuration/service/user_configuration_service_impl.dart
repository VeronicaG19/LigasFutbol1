import 'package:injectable/injectable.dart';

import '../../../../environment_config.dart';
import '../../../core/typedefs.dart';
import '../../roles/entity/user_rol.dart';
import '../../roles/service/i_rol_service.dart';
import '../entity/user_configuration.dart';
import '../repository/i_user_configuration_repository.dart';
import 'i_user_configuration_service.dart';

@LazySingleton(as: IUserConfigurationService)
class UserConfigurationServiceImpl implements IUserConfigurationService {
  final IUserConfigurationRepository _repository;
  final IRolService _rolService;

  UserConfigurationServiceImpl(this._repository, this._rolService);

  @override
  RepositoryResponse<UserConfiguration> createUserConfiguration(
      UserConfiguration configuration) {
    return _repository.createUserConfiguration(configuration);
  }

  @override
  RepositoryResponse<UserConfiguration> deleteUserConfiguration(int id) {
    return _repository.deleteUserConfiguration(id);
  }

  @override
  Future<List<UserRol>> getUserConfiguration(int userId) async {
    final response =
        await _rolService.getUserRoles(userId, EnvironmentConfig.orgId);
    final roles = response.getOrElse(() => []);
    final List<UserRol> result = [];
    for (final e in roles) {
      result.add(e.copyWith(
          configuration: await _getUserConfigurationByUserRolId(e.userRolId)));
    }
    return result;
  }

  @override
  RepositoryResponse<UserConfiguration> updateUserConfiguration(
      UserConfiguration configuration) {
    return _repository.updateUserConfiguration(configuration);
  }

  @override
  UserRol getPrimaryConfiguration(List<UserRol> roles) {
    final config = roles.isNotEmpty
        ? roles.firstWhere((element) => element.primaryFlag == 'Y')
        : UserRol.empty;
    return config;
  }

  Future<UserConfiguration> _getUserConfigurationByUserRolId(
      int userRolId) async {
    final response =
        await _repository.getUserConfigurationByUserRolId(userRolId);
    return response.getOrElse(() => UserConfiguration.empty);
  }
}
