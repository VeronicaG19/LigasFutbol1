import 'package:ligas_futbol_flutter/src/core/models/common_pageable_response.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/full_player_vs_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/player_dto.dart';

import '../../../core/typedefs.dart';
import '../dto/validate_request_dto.dart';
import '../entity/player.dart';

abstract class IPlayerService {
  RepositoryResponse<Player> getDataPlayerByPartyId(int personId);
  RepositoryResponse<Player> savePlayer(Player player);
  RepositoryResponse<Player> updatePlayer(Player player);
  RepositoryResponse<void> deletePlayer(int id);
  RepositoryResponse<ValidateRequestDTO> getvalidatedRequest(
      int partyid, int teamId);
  RepositoryResponse<CommonPageableResponse<FullPlayerVsDTO>> getSearchPlayer({
    int? page,
    int? size,
    int? teamId,
    String? playerName,
    int? preferenceposition,
  });

  /// ? Get all players by team id
  /// @params [teamId]
  ///
  RepositoryResponse<List<PlayerDTO>> getTeamPlayers(int teamId);
}
