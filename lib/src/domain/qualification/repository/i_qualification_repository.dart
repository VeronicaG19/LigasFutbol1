import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../../core/typedefs.dart';
import '../dto/qualification_dto/qualification_dto.dart';
import '../dto/rating_topics/rating_topics_dto.dart';
import '../dto/save_qualifications_dto/save_qualification_dto.dart';
import '../entity/qualification.dart';

abstract class IQualificationRepository {
  RepositoryResponse<ResultDTO> createQualification(
      SaveQualificationDTO saveQualification,
      {int? teamId});

  RepositoryResponse<List<Qualification>> getRatingDetailList(
      int matchId, String type);

  RepositoryResponse<List<RatingTopicsDTO>> getRatingTopics(int matchId);

  RepositoryResponse<List<Qualification>> getAllQalificationsByEntity(
      int entityId, String filterTypeId);

  RepositoryResponse<QualificationDTO> getExistQualification(int evaluatedId,
      int evaluatorId, int leagueId, int matchId, String typeQualification);

  RepositoryResponse<List<QualificationDTO>> getQualificationByMatchAndType(
      int matchId, String type);
}
