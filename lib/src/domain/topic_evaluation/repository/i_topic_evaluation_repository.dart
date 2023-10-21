import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import '../entity/topic_evaluation.dart';
import '../qualificationByMatchEntity/QualificationByMatch.dart';

abstract class ITopicEvaluationRepository{
  RepositoryResponse<List<TopicEvaluation>> getTopicsEvaluationByType(String type);

  RepositoryResponse<List<QualificationByMatch>> getTopicsEvaluationByTypeId(int matchId, {String? typeId});
}