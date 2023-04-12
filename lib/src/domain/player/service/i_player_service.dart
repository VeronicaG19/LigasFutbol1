import 'package:ligas_futbol_flutter/src/domain/player/dto/player_dto.dart';

import '../../../core/typedefs.dart';
import '../dto/search_player_dto.dart';
import '../dto/validate_request_dto.dart';
import '../entity/player.dart';

abstract class IPlayerService {
  RepositoryResponse<Player> getDataPlayerByPartyId(int personId);
  RepositoryResponse<Player> savePlayer(Player player);
  RepositoryResponse<Player> updatePlayer(Player player);
  RepositoryResponse<void> deletePlayer(int id);
  RepositoryResponse<ValidateRequestDTO> getvalidatedRequest(
      int partyid, int teamId);
  RepositoryResponse<List<SearchPlayerDTO>> getSearchPlayer(
      int teamId, int preferenceposition);

  /// ? Get all players by team id
  /// @params [teamId]
  ///
  RepositoryResponse<List<PlayerDTO>> getTeamPlayers(int teamId);
}
