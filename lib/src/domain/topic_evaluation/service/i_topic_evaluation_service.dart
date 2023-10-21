import '../../../core/typedefs.dart';
import '../entity/topic_evaluation.dart';
import '../qualificationByMatchEntity/QualificationByMatch.dart';

abstract class ITopicEvaluationService{
  RepositoryResponse<List<TopicEvaluation>> getTopicsEvaluationByType(String type);

  RepositoryResponse<List<QualificationByMatch>> getTopicsEvaluationByTypeId(int matchId,  {String? typeId});

}