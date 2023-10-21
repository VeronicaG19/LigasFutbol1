import '../../../core/typedefs.dart';
import '../dto/recomendationDTO.dart';
import '../entity/recommendations.dart';

abstract class IRecommendationService {
  RepositoryResponse<Recommendations> postRecommendation(
      Recommendations recommendations);

  RepositoryResponse<List<RecomendationDto>> getRecomendationsByTeam(
      int teamId);

  RepositoryResponse<String> responseRecomendation(
      int recomendationId, bool response);
}
