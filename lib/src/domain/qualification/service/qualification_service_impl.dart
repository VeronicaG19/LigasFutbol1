import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/qualification_dto/qualification_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/rating_topics/rating_topics_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/save_qualifications_dto/save_qualification_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/entity/qualification.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../repository/i_qualification_repository.dart';
import 'i_qualification_service.dart';

@LazySingleton(as: IQualificationService)
class QualificationServiceImpl implements IQualificationService {
  final IQualificationRepository _repository;

  QualificationServiceImpl(this._repository);

  @override
  RepositoryResponse<ResultDTO> createQualification(
      SaveQualificationDTO saveQualification,
      {int? teamId}) {
    return _repository.createQualification(saveQualification, teamId: teamId);
  }

  @override
  RepositoryResponse<List<Qualification>> getRatingDetailList(
          int matchId, String type) =>
      _repository.getRatingDetailList(matchId, type);

  @override
  RepositoryResponse<List<RatingTopicsDTO>> getRatingTopics(int matchId) =>
      _repository.getRatingTopics(matchId);

  @override
  RepositoryResponse<List<Qualification>> getAllQalificationsByEntity(
          int entityId, String filterTypeId) =>
      _repository.getAllQalificationsByEntity(entityId, filterTypeId);

  @override
  RepositoryResponse<QualificationDTO> getExistQualification(int evaluatedId,
      int evaluatorId, int leagueId, int matchId, String typeQualification) {
    return _repository.getExistQualification(
      evaluatedId,
      evaluatorId,
      leagueId,
      matchId,
      typeQualification,
    );
  }

  @override
  RepositoryResponse<List<QualificationDTO>> getQualificationByMatchAndType(
      int matchId, String type) =>
      _repository.getQualificationByMatchAndType(matchId, type);

}
