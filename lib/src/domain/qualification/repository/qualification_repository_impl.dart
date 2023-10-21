import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/qualification_dto/qualification_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/rating_topics/rating_topics_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/save_qualifications_dto/save_qualification_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/entity/qualification.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../../core/endpoints.dart';
import 'i_qualification_repository.dart';

@LazySingleton(as: IQualificationRepository)
class QualificationImpl implements IQualificationRepository {
  final ApiClient _apiClient;

  QualificationImpl(this._apiClient);

  @override
  RepositoryResponse<ResultDTO> createQualification(
      SaveQualificationDTO saveQualification,
      {int? teamId}) {
    return _apiClient.network
        .postData(
            endpoint: (teamId != null)
                ? '$saveQualifications?teamid=$teamId'
                : saveQualifications,
            data: saveQualification.toJson(),
            converter: ResultDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Qualification>> getRatingDetailList(
          int matchId, String type) =>
      _apiClient.fetchCollectionData(
          endpoint: '$qualificationTopicsEndpoint/$matchId/$type',
          converter: Qualification.fromJson);

  @override
  RepositoryResponse<List<RatingTopicsDTO>> getRatingTopics(int matchId) =>
      _apiClient.fetchCollectionData(
          endpoint: '$qualificationTopicsEndpoint/$matchId?typeId=MATCH',
          converter: RatingTopicsDTO.fromJson);

  @override
  RepositoryResponse<List<Qualification>> getAllQalificationsByEntity(
          int entityId, String filterTypeId) =>
      _apiClient.fetchCollectionData(
          endpoint: '$getDetailevaluated/$entityId/$filterTypeId',
          converter: Qualification.fromJson);

  @override
  RepositoryResponse<QualificationDTO> getExistQualification(int evaluatedId,
      int evaluatorId, int leagueId, int matchId, String typeQualification) {
    return _apiClient.network
        .getData(
            endpoint: getExistQualificationEndpoint,
            queryParams: {
              'evaluatedId': evaluatedId,
              'evaluatorId': evaluatorId,
              'leagueId': leagueId,
              'matchId': matchId,
              'typeQualification': typeQualification
            },
            converter: QualificationDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<QualificationDTO>> getQualificationByMatchAndType(
      int matchId, String type) =>
      _apiClient.fetchCollectionData(
          endpoint: '$qualificationTopicsEndpoint/$matchId/$type',
          converter: QualificationDTO.fromJson
      );
}
