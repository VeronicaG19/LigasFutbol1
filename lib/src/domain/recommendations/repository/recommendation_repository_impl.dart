import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../entity/recommendations.dart';
import 'i_recommendation_repository.dart';

@LazySingleton(as: IRecommendationsRepository)
class RecommendationsRepositoryImpl implements IRecommendationsRepository {
  final ApiClient _apiClient;

  RecommendationsRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<Recommendations> createRecommendation(
      Recommendations recommendations) {
    return _apiClient.network
        .postData(
            endpoint: postRecommendationsEndpoint,
            data: recommendations.toJson(),
            converter: Recommendations.fromJson)
        .validateResponse();
  }
}
