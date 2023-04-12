import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/repository/i_uniform_repository.dart';
import '../../../core/typedefs.dart';

import 'i_uniform_service.dart';

@LazySingleton(as: IUniformService)
class UniformServiceImpl implements IUniformService {
  final IUniformRepository _repository;

  UniformServiceImpl(this._repository);

  @override
  RepositoryResponse<List<UniformDto>> getUniformsByTeamId(int teamId) {
    return _repository.getUniformsByTeamId(teamId);
  }

  @override
  RepositoryResponse<UniformDto> saveUniformOfTeam(UniformDto uniformDto) {
    return _repository.saveUniformOfTeam(uniformDto);
  }
}
