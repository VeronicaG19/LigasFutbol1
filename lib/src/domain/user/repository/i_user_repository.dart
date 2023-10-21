import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user/dto/user_dto.dart';

abstract class IUserRepository {
  /// * deactivateAccount
  /// ? deactivate account permanently
  /// @param [userDTO]
  RepositoryResponse<UserDTO> deactivateAccount(UserDTO userDTO);

  /// * deleteAccount
  /// ? delete account permanently
  /// @param [player]
  RepositoryResponse<ResultDTO> deleteAccount(Player player);
}
