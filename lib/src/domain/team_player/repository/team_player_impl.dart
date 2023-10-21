import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/dto/create_team_player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/dto/player_into_team_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../entity/player_by_team.dart';
import '../entity/team_player.dart';
import 'i_team_player_repository.dart';

@LazySingleton(as: ITeamPlayerRepository)
class TeamPlayerRepositoryImpl implements ITeamPlayerRepository {
  final ApiClient _apiClient;

  TeamPlayerRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<TeamPlayer>> getTeamPlayer(int partyId, int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getTeamPlayerEndpoint?partyId=$partyId&teamId=$teamId",
            converter: TeamPlayer.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> deleteTeamPlayer(int teamPlayerId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$deleteTeamPlayerEndpoint/$teamPlayerId',
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<PlayerByTeam>> getPlayersByTeam(int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$playersByTeamEndpoint/$teamId',
            converter: PlayerByTeam.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<PlayerIntoTeamDTO>> getPlayersIntoTeam(int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getPlayesInTeamAdmin$teamId',
            converter: PlayerIntoTeamDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<CreateTeamPlayerDTO> createTeamPlayer(
      CreateTeamPlayerDTO teamPlayer) {
    return _apiClient.network
        .postData(
            endpoint: createTeamPlayerEndpoint,
            data: teamPlayer.ToJsonCreate(),
            converter: CreateTeamPlayerDTO.fromJson)
        .validateResponse();
  }
}
