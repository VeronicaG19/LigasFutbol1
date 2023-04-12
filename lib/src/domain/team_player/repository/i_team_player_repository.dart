import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import '../dto/create_team_player_dto.dart';
import '../dto/player_into_team_dto.dart';
import '../entity/player_by_team.dart';
import '../entity/team_player.dart';

abstract class ITeamPlayerRepository {
  RepositoryResponse<List<TeamPlayer>> getTeamPlayer(int partyId, int teamId);
  RepositoryResponse<List<PlayerByTeam>> getPlayersByTeam(int teamId);
  RepositoryResponse<String> deleteTeamPlayer(int teamPlayerId);
  RepositoryResponse<List<PlayerIntoTeamDTO>> getPlayersIntoTeam(int teamId);
  RepositoryResponse<CreateTeamPlayerDTO> createTeamPlayer(CreateTeamPlayerDTO teamPlayer);

}
