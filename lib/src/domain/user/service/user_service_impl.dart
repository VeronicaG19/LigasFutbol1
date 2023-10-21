import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user/dto/user_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user/repository/i_user_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/user/service/i_user_service.dart';

@LazySingleton(as: IUserService)
class UserServiceImpl implements IUserService {
  final IUserRepository _repository;

  UserServiceImpl(this._repository);

  @override
  RepositoryResponse<UserDTO> deactivateAccount(UserDTO userDTO) {
    return _repository.deactivateAccount(userDTO);
  }

  @override
  RepositoryResponse<ResultDTO> deleteAccount(Player player) {
    return _repository.deleteAccount(player);
  }
}
