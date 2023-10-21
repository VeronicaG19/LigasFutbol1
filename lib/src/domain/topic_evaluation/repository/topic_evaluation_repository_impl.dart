import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/topic_evaluation/repository/i_topic_evaluation_repository.dart';
import '../../../core/endpoints.dart';
import '../entity/topic_evaluation.dart';
import '../qualificationByMatchEntity/QualificationByMatch.dart';

@LazySingleton(as: ITopicEvaluationRepository)
class TopicEvaluationRepositoryImpl implements ITopicEvaluationRepository{
  final ApiClient _apiClient;

  TopicEvaluationRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<TopicEvaluation>> getTopicsEvaluationByType(String type) {
    return _apiClient.network.getCollectionData(
        endpoint: '$getTopicsEvaluationEndpoint/$type',
        converter: TopicEvaluation.fromJson
    ).validateResponse();
  }

  @override
  RepositoryResponse<List<QualificationByMatch>> getTopicsEvaluationByTypeId(int matchId, {String? typeId}) {
    final data = <String, dynamic>{};

    data.addAll({'typeId': typeId});
    return _apiClient.network.getCollectionData(
        endpoint: '$getQualificationToTopics$matchId', 
        queryParams: data,
        converter: QualificationByMatch.fromJson
    ).validateResponse();
  }

}