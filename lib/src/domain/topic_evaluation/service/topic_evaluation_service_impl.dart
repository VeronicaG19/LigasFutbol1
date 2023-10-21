import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/topic_evaluation/repository/i_topic_evaluation_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/topic_evaluation/service/i_topic_evaluation_service.dart';

import '../entity/topic_evaluation.dart';
import '../qualificationByMatchEntity/QualificationByMatch.dart';

@LazySingleton(as: ITopicEvaluationService)
class TopicEvaluationServiceImpl implements ITopicEvaluationService{
  final ITopicEvaluationRepository _repository;

  TopicEvaluationServiceImpl(this._repository);

  @override
  RepositoryResponse<List<TopicEvaluation>> getTopicsEvaluationByType(String type) {
    return _repository.getTopicsEvaluationByType(type);
  }

  @override
  RepositoryResponse<List<QualificationByMatch>> getTopicsEvaluationByTypeId(int matchId,  {String? typeId}) {
    return _repository.getTopicsEvaluationByTypeId(matchId, typeId: typeId);
  }
}