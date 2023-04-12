import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/entity/scoring_table.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/dto/scoring_table_dto.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/service/i_scoring_table_service.dart';

import '../repository/i_scoring_table_repository.dart';

@LazySingleton(as: IScoringTableService)
class ScoringTableServiceImpl implements IScoringTableService{
  final IScoringTableRepository _repository;

  ScoringTableServiceImpl(this._repository);

  @override
  RepositoryResponse<ScoringTable> createScoringTablePresident(ScoringTable scoringTable) {
      return _repository.createScoringTablePresident(scoringTable);
    }
  
    @override
    RepositoryResponse<List<ScroginTableDTO>> getScoringTable(int tournamentId) {
      return _repository.getScoringTable(tournamentId);
  }
}