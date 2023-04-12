import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/recommendations.dart';

abstract class IRecommendationsRepository {
  RepositoryResponse<Recommendations> createRecommendation(
      Recommendations recommendations);
}
