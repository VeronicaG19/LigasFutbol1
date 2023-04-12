import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/player_experience/entity/player_experience.dart';

import '../../../core/endpoints.dart';
import 'i_player_experience_repository.dart';

@LazySingleton(as: IPlayerExperienceRepository)
class PlayerExperienceRepositoryImpl implements IPlayerExperienceRepository {
  final ApiClient _apiClient;
  const PlayerExperienceRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<PlayerExperience>> getPlayerExperience(int personId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$playerExperienceEndpoint/$personId',
            converter: PlayerExperience.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<PlayerExperience> createExperience(
      PlayerExperience experience) {
    return _apiClient.network
        .postData(
            endpoint: playerExperienceEndpoint,
            data: experience.toJson(),
            converter: PlayerExperience.fromJson)
        .validateResponse();
  }
}
