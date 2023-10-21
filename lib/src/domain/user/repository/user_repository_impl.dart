import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user/dto/user_dto.dart';
import '../../../core/endpoints.dart';

import 'i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<UserDTO> deactivateAccount(UserDTO userDTO) {
    return _apiClient.network
        .updateData(
          endpoint: deactivateAccountEndpoint,
          data: userDTO.toJson(),
          converter: UserDTO.fromJson,
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<ResultDTO> deleteAccount(Player player) {
    return _apiClient.network
        .postData(
          endpoint: deleteAccountEndpoint,
          data: player.toJson(),
          converter: ResultDTO.fromJson,
        )
        .validateResponse();
  }
}
