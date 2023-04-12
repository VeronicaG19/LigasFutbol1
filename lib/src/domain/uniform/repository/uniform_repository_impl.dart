import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/typedefs.dart';
import 'i_uniform_repository.dart';

@LazySingleton(as: IUniformRepository)
class UniformRepositoryImpl implements IUniformRepository {
  final ApiClient _apiClient;

  UniformRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<UniformDto>> getUniformsByTeamId(int teamId) {
    return _apiClient.network
        .getCollectionData(
          converter: UniformDto.fromJson,
          endpoint: '$getUniformsEndpoint$teamId',
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<UniformDto> saveUniformOfTeam(UniformDto uniformDto) {
    final data = jsonEncode(uniformDto);
    return _apiClient.network
        .postData(
            endpoint: saveUniformEndpoint,
            data: {},
            dataAsString: data, //tournament.tojsonUpdateCreate(),
            converter: UniformDto.fromJson)
        .validateResponse();
  }
}
