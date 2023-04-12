import '../../../core/typedefs.dart';
import '../dto/create_team_player_dto.dart';
import '../dto/player_into_team_dto.dart';
import '../entity/player_by_team.dart';
import '../entity/team_player.dart';

abstract class ITeamPlayerService {
  RepositoryResponse<List<TeamPlayer>> getTeamPlayer(int partyId, int teamId);

  ///Obtiene una lista de [PlayerByTeam]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<List<PlayerByTeam>> getPlayersByTeam(int teamId);

  ///Elimina mediante un id. Devuelve un String como respuesta.
  RepositoryResponse<String> deleteTeamPlayer(int teamPlayerId);
  
  ///Obtiene los jugadores de un equipo
  RepositoryResponse<List<PlayerIntoTeamDTO>> getPlayersIntoTeam(int teamId);
  RepositoryResponse<CreateTeamPlayerDTO> createTeamPlayer(CreateTeamPlayerDTO teamPlayer);
}
