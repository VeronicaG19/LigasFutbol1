import 'package:injectable/injectable.dart';

import '../../../core/typedefs.dart';
import '../entity/recommendations.dart';
import '../repository/i_recommendation_repository.dart';
import 'i_recommendation_service.dart';

@LazySingleton(as: IRecommendationService)
class RecommendationServiceImpl implements IRecommendationService {
  final IRecommendationsRepository _repository;

  RecommendationServiceImpl(this._repository);
  @override
  RepositoryResponse<Recommendations> postRecommendation(
      Recommendations recommendations) {
    return _repository.createRecommendation(recommendations);
  }
}
