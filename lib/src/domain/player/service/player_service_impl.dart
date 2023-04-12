import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/search_player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/validate_request_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/repository/i_player_repository.dart';

import 'i_player_service.dart';

@LazySingleton(as: IPlayerService)
class PlayerServiceImpl implements IPlayerService {
  final IPlayerRepository _repository;

  PlayerServiceImpl(this._repository);

  @override
  RepositoryResponse<void> deletePlayer(int id) {
    return _repository.deletePlayer(id);
  }

  @override
  RepositoryResponse<Player> savePlayer(Player player) {
    return _repository.savePlayer(player);
  }

  @override
  RepositoryResponse<Player> updatePlayer(Player player) {
    return _repository.updatePlayer(player);
  }

  @override
  RepositoryResponse<Player> getDataPlayerByPartyId(int partyId) {
    return _repository.getDataPlayerByPartyId(partyId);
  }

  @override
  RepositoryResponse<ValidateRequestDTO> getvalidatedRequest(
      int partyid, int teamId) {
    return _repository.getvalidatedRequest(partyid, teamId);
  }

  @override
  RepositoryResponse<List<SearchPlayerDTO>> getSearchPlayer(
      int teamId, int preferenceposition) {
    return _repository.getSearchPlayer(teamId, preferenceposition);
  }

  @override
  RepositoryResponse<List<PlayerDTO>> getTeamPlayers(int teamId) {
    return _repository.getTeamPlayers(teamId);
  }
}
