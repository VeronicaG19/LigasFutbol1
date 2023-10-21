import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/endpoints.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/models/common_pageable_response.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/full_player_vs_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/validate_request_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/repository/i_player_repository.dart';

@LazySingleton(as: IPlayerRepository)
class PlayerRepositoryImpl implements IPlayerRepository {
  final ApiClient _apiClient;
  PlayerRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<void> deletePlayer(int id) {
    return _apiClient.network
        .deleteData(
            endpoint: '$getDataPlayerByIdEndpoint/$id',
            converter: Player.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Player> savePlayer(Player player) {
    return _apiClient.network
        .postData(
            endpoint: createPlayer,
            data: player.toJson(),
            converter: Player.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Player> updatePlayer(Player player) async {
    return _apiClient.network
        .updateData(
            endpoint: getUpdatePlayerEndpoint,
            data: player.toJsonUpdate(),
            converter: Player.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Player> getDataPlayerByPartyId(int partyId) {
    return _apiClient.network
        .getData(
            endpoint: '$getDataPlayerByIdEndpoint/$partyId',
            converter: Player.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ValidateRequestDTO> getvalidatedRequest(
      int partyId, int teamId) {
    return _apiClient.network
        .getData(
            endpoint: '$getValidationRequest/$partyId/$teamId',
            converter: ValidateRequestDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<CommonPageableResponse<FullPlayerVsDTO>> getSearchPlayer({
    int? page,
    int? size,
    int? teamId,
    String? playerName,
    int? preferenceposition,
  }) {
    final data = <String, dynamic>{};
    if (page != null) {
      data.addAll({'page': page});
    }
    data.addAll({'size': size ?? 10});

    data.addAll({'playerName': playerName});
    data.addAll({'preferenceposition': preferenceposition});

    return _apiClient.network
        .getData(
          endpoint: "$getSearchPlayerEndpoint/$teamId",
          queryParams: data,
          converter: (response) {
            return CommonPageableResponse.fromJson(
              json: response,
              converter: FullPlayerVsDTO.fromJson,
              item: 'fullPlayerVs',
            );
          },
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<List<PlayerDTO>> getTeamPlayers(int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getTeamPlayersEndpoint$teamId",
            converter: PlayerDTO.fromJson)
        .validateResponse();
  }
}
