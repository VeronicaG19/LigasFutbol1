import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../dto/recomendationDTO.dart';
import '../entity/recommendations.dart';

abstract class IRecommendationsRepository {
  RepositoryResponse<Recommendations> createRecommendation(
      Recommendations recommendations);

  
  RepositoryResponse<List<RecomendationDto>> getRecomendationsByTeam(
      int teamId);

  RepositoryResponse<String> responseRecomendation(
      int recomendationId, bool response);

      
}
