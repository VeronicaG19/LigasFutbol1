import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../dto/scoring_table_dto.dart';
import '../entity/scoring_table.dart';

abstract class IScoringTableRepository{
  
  ///Metodo para crear un registro en scoring table
  /// * @param scoringTable
  /// 
  RepositoryResponse<ScoringTable> createScoringTablePresident(ScoringTable scoringTable);
  
  /// Metodo que obtiene la lista de la tabla de goleo
  /// * @param tournamentId
  /// * @responde [list of ScroginTableDTO]
  RepositoryResponse<List<ScroginTableDTO>> getScoringTable(int tournamentId);
}