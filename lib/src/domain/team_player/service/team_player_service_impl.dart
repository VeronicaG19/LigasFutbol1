import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/dto/create_team_player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/dto/player_into_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/player_by_team.dart';

import '../../../core/typedefs.dart';
import '../entity/team_player.dart';
import '../repository/i_team_player_repository.dart';
import 'i_team_player_service.dart';

@LazySingleton(as: ITeamPlayerService)
class TeamPlayerServiceImpl implements ITeamPlayerService {
  final ITeamPlayerRepository _repository;

  TeamPlayerServiceImpl(this._repository);
  @override
  RepositoryResponse<List<TeamPlayer>> getTeamPlayer(int partyId, int teamId) {
    return _repository.getTeamPlayer(partyId, teamId);
  }

  @override
  RepositoryResponse<String> deleteTeamPlayer(int teamPlayerId) {
    return _repository.deleteTeamPlayer(teamPlayerId);
  }

  @override
  RepositoryResponse<List<PlayerByTeam>> getPlayersByTeam(int teamId) async {
    return _repository.getPlayersByTeam(teamId);
  }

  @override
  RepositoryResponse<List<PlayerIntoTeamDTO>> getPlayersIntoTeam(int teamId) {
    return _repository.getPlayersIntoTeam(teamId);
  }

  @override
  RepositoryResponse<CreateTeamPlayerDTO> createTeamPlayer(CreateTeamPlayerDTO teamPlayer) {
    return _repository.createTeamPlayer(teamPlayer);
  }
}
