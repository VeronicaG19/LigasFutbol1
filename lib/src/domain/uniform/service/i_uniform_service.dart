import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';

abstract class IUniformService {
  ///
  /// * get uniforms of team(visitor & local)
  ///
  /// @param[teamId]
  RepositoryResponse<List<UniformDto>> getUniformsByTeamId(int teamId);

  ///
  /// * save uniforms of team(visitor & local)
  ///
  /// @param[uniformDto]
  RepositoryResponse<UniformDto> saveUniformOfTeam(UniformDto uniformDto);
}
