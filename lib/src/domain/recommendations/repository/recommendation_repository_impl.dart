import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/recommendations/dto/recomendationDTO.dart';

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

  @override
  RepositoryResponse<List<RecomendationDto>> getRecomendationsByTeam(int teamId) {
    return _apiClient.network.getCollectionData(
      endpoint: '$getRecomendationsByTeamEndpoint$teamId', 
      converter: RecomendationDto.fromJson).validateResponse();
  }

  @override
  RepositoryResponse<String> responseRecomendation(int recomendationId, bool response) {
    return _apiClient.network.updateData(
      endpoint: '$responseRecomendationEndpoint$recomendationId?response=$response', 
      data: null, 
      converter: (result) => result['result'] as String).validateResponse();
  }
}
