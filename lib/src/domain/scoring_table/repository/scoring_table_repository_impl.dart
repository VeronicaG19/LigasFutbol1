import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/endpoints.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/entity/scoring_table.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/dto/scoring_table_dto.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import '../../../core/extensions.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_table/repository/i_scoring_table_repository.dart';

@LazySingleton(as: IScoringTableRepository)
class ScoringTableRepositoryImpl implements IScoringTableRepository {

  final ApiClient _apiClient;

  ScoringTableRepositoryImpl(this._apiClient);


  @override
  RepositoryResponse<ScoringTable> createScoringTablePresident(ScoringTable scoringTable) {
     return _apiClient.network.postData(
       endpoint: getCreateScoringTableData, 
       data: scoringTable.toJson(), 
       converter: ScoringTable.fromJson).validateResponse();
    }
  
    @override
    RepositoryResponse<List<ScroginTableDTO>> getScoringTable(int tournamentId) {
    return _apiClient.network.getCollectionData(
      endpoint: '$getScoringTableData$tournamentId', 
    converter: ScroginTableDTO.fromJson).validateResponse();
  }
}