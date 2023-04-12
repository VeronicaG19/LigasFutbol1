import '../../../core/typedefs.dart';
import '../entity/recommendations.dart';

abstract class IRecommendationService {
  RepositoryResponse<Recommendations> postRecommendation(
      Recommendations recommendations);
}
