import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/player_experience.dart';
import '../repository/i_player_experience_repository.dart';
import 'i_player_experience_service.dart';

@LazySingleton(as: IPlayerExperienceService)
class PlayerExperienceServiceImpl implements IPlayerExperienceService {
  final IPlayerExperienceRepository _repository;
  const PlayerExperienceServiceImpl(this._repository);

  @override
  Future<List<PlayerExperience>> getPlayerExperience(int personId) async {
    final request = await _repository.getPlayerExperience(personId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<PlayerExperience> createExperience(
      PlayerExperience experience) {
    return _repository.createExperience(experience);
  }
}
