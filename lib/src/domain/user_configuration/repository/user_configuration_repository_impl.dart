import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';

import '../../../core/endpoints.dart';
import '../../../core/typedefs.dart';
import '../../roles/entity/user_rol.dart';
import '../entity/user_configuration.dart';
import 'i_user_configuration_repository.dart';

@LazySingleton(as: IUserConfigurationRepository)
class UserConfigurationRepositoryImpl implements IUserConfigurationRepository {
  final ApiClient _apiClient;

  const UserConfigurationRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<UserConfiguration> createUserConfiguration(
      UserConfiguration configuration) {
    return _apiClient.network
        .postData(
            endpoint: getUserConfigurationEndpoint,
            data: configuration.toJson(),
            converter: UserConfiguration.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserConfiguration> deleteUserConfiguration(int id) {
    return _apiClient.network
        .deleteData(
            endpoint: '$getUserConfigurationEndpoint/$id',
            converter: UserConfiguration.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRol>> getUserConfiguration(int userId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getUserConfigurationDataEndpoint/$userId',
            converter: UserRol.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserConfiguration> updateUserConfiguration(
      UserConfiguration configuration) {
    return _apiClient.network
        .updateData(
            endpoint: getUserConfigurationEndpoint,
            data: configuration.toJson(),
            converter: UserConfiguration.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserConfiguration> getUserConfigurationByUserRolId(
      int userRolId) {
    return _apiClient.network
        .getData(
            endpoint: '$getUserConfigurationByUserRolIdEndpoint/$userRolId',
            converter: UserConfiguration.fromJson)
        .validateResponse();
  }
}
